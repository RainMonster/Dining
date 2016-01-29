class UsersController < ApplicationController
  before_filter :unless_current_user, only: [:show]
  # before_filter :authenticate_user!, only: [:edit, :update]

  def new
    if current_user && current_user.has_facebook?
      @user = current_user
    else
      @user = RegularUser.new
    end
  end

  def create
    @user = RegularUser.new(user_params)
    subscribe = params[:regular_user][:email_subscriber]

    if @user.save && @user.email_subscriber(subscribe)
      @user.subscribe_to_mailing_list
      login @user
    elsif @user.save
      login @user
    else
      render action: 'new'
    end
  end

  def show
    @user = current_user
    @host = @user.user_is_a_host
    @reserved_events = display_upcoming_reserved_events(@user)
    @past_reserved_events = display_past_reserved_events(@user)
    @waiting_list_events = display_upcoming_waiting_list_events(@user)
  end

  def edit
    @user = User.find(session[:user_id])
    if @user.has_stored_card?
      @card = @user.credit_cards.first
    else
      @card = CreditCard.new
    end
  end

  def update
  end

  def host_application
    @user = User.find(session[:user_id])
  end

  def send_host_application
    @user = current_user
    # This resque queue has an argument error which doesn't read the user
    # Resque.enqueue(UserHostApplicationJob, @user, message_params)
    UserMailer.send_host_application(@user.id, message_params).deliver
    # .deliver! performs synchronously
    flash[:notice] = "Thank you for your application. We will review it and get back to you shortly."

    redirect_to user_path @user
  end

  private

  # Require that :user be a key in the params Hash,
  # and only accept :first, :last, and :email attributes
  def user_params
    params.require(:regular_user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :email_subscriber)
  end

  def message_params
    params.require("message").permit("first_name", "last_name", "phone_number", "question_1", "question_2", "question_3", "question_4", "question_5", "terms")
  end

  def login user
    session[:user_id] = user.id
    redirect_to root_path
  end

end
