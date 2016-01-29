class ReservationsMailer < ActionMailer::Base
  include ApplicationHelper
  helper :Application
  default from: "admin@nommery.com"

  def send_waiting_list(event)
    @event = event
    waiting_list_reservations = event.reservations.where(status: "Waiting_List")

    waiting_list_reservations.each do |reservation|
      begin
        @reservation = reservation
        mail(from: "admin@nommery.com", to: reservation.user.email, subject: "There is an opening for #{@event.restaurant_name}")
      rescue => e
        logger.info(e)
        logger.info(reservation.id)
      end
    end
    
  end

end
