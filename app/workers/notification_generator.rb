class NotificationGenerator
  include Sidekiq::Worker

  def perform
    sd = DateTime.now
    ed = sd + 10.minutes
    events = Event.where(start_date: sd..ed)

    events.each do |event|
      PusherTrigger.perform_async(event.id,
                                  Event::CHANNELS_MAP[:notifications],
                                  Event::EVENTS_MAP[:new_notification])
    end
  end
end
