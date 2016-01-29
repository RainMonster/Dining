module EventsJob
  @queue = :events_time_queue

  def self.perform()
    puts "EventsJob is performing"
    events = Event.where(over: false)
    events.each do |event|
      if event.past_event
        event.over = true
        event.save
      end
    end
  end

end