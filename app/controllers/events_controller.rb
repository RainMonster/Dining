class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :current_host_created_event, only: [:edit, :update, :destroy]
  before_action :unless_a_host, only: [:new, :create]

  def index
    @events = Event.filter_events
  end

  def filter_by_region
    @events = Event.filter_events(params['Events By Region'])
    render :index
  end

  def show
  end

  def new
    @host = current_user.user_is_a_host
    @event = Event.new
  end

  def edit
    @host = current_user.user_is_a_host
  end

  def create
    # TOFIX: After OpenTable API this area needs to tie into the Event model's validations and not save unless those requirements are met. Currently no validations.
    @event = Event.new(event_params)
    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to @event
    else
      flash[:notice] = "#{@event.errors}"
      render action: 'new'
    end
  end

  def update
    if @event.update(event_params)
      flash[:notice] = 'Event was successfully updated.'
      redirect_to @event
    else
      flash[:notice] = "#{@event.errors}"
      render action: 'edit'
    end
  end

  def destroy
    @event.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:user_id, :number_of_seats, :neighborhood, :picture_of_dish, :region, :restaurant_name, :description, :RSVP_deadline, :event_time, :amount)
    end

    def current_host_created_event
      @event = Event.find(params[:id])
      if current_user != @event.user
        redirect_to events_path
      end
    end
end

