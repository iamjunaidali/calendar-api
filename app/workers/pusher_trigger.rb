class PusherTrigger
  include Sidekiq::Worker
  sidekiq_options queue: 'pusher'

  def perform(event_id, channel, event)
    PusherService.new(event_id, channel, event).trigger
  end
end
