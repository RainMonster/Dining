class CreditCardsController < ApplicationController

  def new
    @card = CreditCard.new
  end

  def show
    @card = CreditCard.find(params[:id])
  end

  def index
    @cards = current_user.credit_cards
  end

  def edit
    @card = CreditCard.find(params[:id])
  end

  def create
    begin
      @result = Braintree::Customer.create(
        :first_name => params['first_name'],
        :last_name => params['last_name'],
        :credit_card => {
          :number => params['number'],
          :expiration_date => "#{params['month']}/#{params['year']}"
          # test for checking for validity here
        }
      )
    rescue SocketError => e
      logger.info(e)
    end
    
    if @result && @result.success?
      customer = @result.customer
      card = customer.credit_cards[0]
      test_card = CreditCard.create(user: current_user, token: card.token, last_4: card.last_4, card_type: card.card_type)
      current_user.update_attribute(:braintree_customer_id, customer.id)
      flash[:notice] = "Your credit card has been added"
      redirect_to edit_user_path current_user
    elsif @result
      flash[:notice] = "Unable to save your card: #{@result.errors}"
      redirect_to edit_user_path current_user
    else
      flash[:notice] = "Unable to establish connection, please try again later"
      redirect_to edit_user_path current_user
    end
  end

  def destroy
    p '& ' * 20
    p params[:id]
    @card = CreditCard.find(params[:id])
    @card.destroy
    flash[:notice] = "Your default card has been removed"
    redirect_to edit_user_path current_user
  end

end
