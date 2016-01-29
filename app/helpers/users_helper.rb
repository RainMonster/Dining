module UsersHelper

  def display_upcoming_reserved_events(user)
    if user.reservations.any?
      events_and_reservations_hash = {}
      events_and_reservations_hash[:reservations] = []
      events_and_reservations_hash[:events] = []
      reservations = user.reservations
      
      reservations.each do |r|
        if !r.event.over? && r.status == "Completed"
          events_and_reservations_hash[:reservations] << r
          events_and_reservations_hash[:events] << r.event
        end
      end

      if events_and_reservations_hash[:reservations].length > 0
        events_and_reservations_hash
      end
    end
  end


  def display_past_reserved_events(user)
    if user.reservations.any?
      past_events_hash = {}
      past_events_hash[:events] = []

      user.reservations.each do |r|
        if r.event.over?
          past_events_hash[:events] << r.event
        end
      end
      
      if past_events_hash[:events].length > 0
        past_events_hash
      end
    end
  end




  def display_upcoming_waiting_list_events(user)
    if user.reservations.any?
      events_and_reservations_hash = {}
      events_and_reservations_hash[:reservations] = []
      events_and_reservations_hash[:events] = []
      reservations = user.reservations
      
      reservations.each do |r|
        if !r.event.over? && r.status == "Waiting_List"
          events_and_reservations_hash[:reservations] << r
          events_and_reservations_hash[:events] << r.event
        end
      end

      if events_and_reservations_hash[:reservations].length > 0
        events_and_reservations_hash
      end
    end
  end

end
