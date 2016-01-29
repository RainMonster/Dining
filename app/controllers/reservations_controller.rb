class ReservationsController < ApplicationController
  require 'braintree'
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @event = Event.find(params[:event_id])
    @reservation = Reservation.new(event_id: @event.id, user_id: current_user.id)
    @user = current_user
    @card = @user.credit_cards.first
  end

  # GET /reservations/1/edit
  def edit
    @event = Event.find(params[:event_id])
    @user = current_user
  end

  # POST /reservations
  # POST /reservations.json
  def create
    @event = Event.find(params[:event_id])
    @user = current_user

    if params[:waiting_list]
      # add user to waiting_list
      @reservation = Reservation.new(reservation_params)
      @reservation.status = "Waiting_List"
      @reservation.save
      flash[:notice] = "You will be notified by email if a seat becomes available!"
      redirect_to event_path @event
    else
      begin
        if params["stored_card"]
          result = Braintree::Transaction.sale(
            amount: params["amount"],
            customer_id: @user.braintree_customer_id
            )
        else
          result = Braintree::Transaction.sale(
            amount: params["amount"],
            credit_card: {
              number: params["number"],
              cvv: params["cvv"],
              expiration_month: params["month"],
              expiration_year: params["year"]
            },
            options: {
              submit_for_settlement: true
            }
          )
        end
      rescue SocketError => e
        logger.info(e)
      end

      if result.success?
        @reservation = Reservation.new(reservation_params)
        @reservation.transaction_number = result.transaction.id
        @reservation.update_attribute(:status, "Completed")
        @event.update_number_of_available_seats
        @event.save
        flash[:notice] = "Reservation was successfully created. Transaction ID: #{result.transaction.id}"
        redirect_to event_path @event
       else
        flash[:notice] = "Error while processing payment: #{result.message}"
        redirect_to event_path @event
       end
     end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    event = @reservation.event
    begin
      result = Braintree::Transaction.sale(
        amount: params["amount"],
          credit_card: {
            number: params["number"],
            cvv: params["cvv"],
            expiration_month: params["month"],
            expiration_year: params["year"]
          },
          options: {
            submit_for_settlement: true
          }
        )
    rescue => e
      result.error
    end

    if result.success?
      @reservation.update_attributes(status: "Completed", transaction_number: result.transaction.id)
      event.update_number_of_available_seats
      event.save

      flash[:notice] = "Reservation was successfully updated. Transaction ID: #{result.transaction.id}"
      redirect_to event_path event
    else
      flash[:notice] = "Error while processing payment: #{result.message}"
      redirect_to event_path event
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @event = @reservation.event
    @reservation.update_attribute(:status, "Cancelled")
    
    begin
      if !@event.available_seats && @event.reservations.where(status: "Waiting_List").any?
        ReservationsMailer.send_waiting_list(@event).deliver
      end
    rescue => e
      logger.info(e)
    end

    @event.save
    flash[:notice] = "Your reservation has been cancelled."
    redirect_to event_path @event
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require('reservation').permit('user_id', 'event_id')
    end
end
