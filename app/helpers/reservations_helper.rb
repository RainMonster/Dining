module ReservationsHelper

  def array_of_emails(array_of_reservations)
    emails = []
    array_of_reservations.each do |reservation|
      if reservation.user.email
        emails << reservation.user.email
      end
    end
    emails
  end

end
