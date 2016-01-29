class Event < ActiveRecord::Base
  belongs_to  :user
  has_many    :reservations
  before_save :update_number_of_available_seats, :update_available_seats

  def self.filter_events(region = nil)
    if region
      available_seats = Event.where(region: region, available_seats: true, over: false).order(event_time: :asc)
      rsvp = Event.where(region: region, available_seats: false, over: false).order(event_time: :asc)
    else
      available_seats = Event.where(available_seats: true, over: false).order(event_time: :asc)
      rsvp = Event.where(available_seats: false, over: false).order(event_time: :asc)
    end
    available_seats + rsvp
  end

  def past_event
    self.event_time < Time.now
  end

  def display_amount
    self.display_in_monetary_format(self.amount)
  end

  def display_in_monetary_format(num)
    sprintf('%.2f', num)
  end

  def update_number_of_available_seats
    self.number_of_available_seats = calculate_available_seats(self)
  end

  def calculate_available_seats(event)
    completed_reservations = event.reservations.where(status: "Completed")
    event.number_of_seats - completed_reservations.length
  end

  private

  def update_available_seats
    if (self.number_of_available_seats < 1 && self.available_seats) || (self.number_of_available_seats >= 1 && !self.available_seats)
      self.toggle(:available_seats)
    end
  end

end
