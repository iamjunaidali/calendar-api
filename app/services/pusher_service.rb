require 'pusher'

class PusherService
  attr_reader :notification_id, :channel, :event

  def initialize(notification_id, channel, event)
    @notification_id = notification_id
    @channel = channel
    @event = event
  end

  def trigger
    client.trigger(
      channel,
      event,
      user_id: notification.user_id,
      user_type: notification.user_type
    )
  end

  def self.configured?
    ENV['PUSHER_APP_ID'].present? && ENV['PUSHER_APP_KEY'].present? &&
      ENV['PUSHER_APP_SECRET'].present? && ENV['PUSHER_APP_CLUSTER'].present?
  end

  private

  def notification
    @notification ||= Notification.find(notification_id)
  end

  def client
    @client ||= Pusher::Client.new(
      app_id: ENV['PUSHER_APP_ID'],
      key: ENV['PUSHER_APP_KEY'],
      secret: ENV['PUSHER_APP_SECRET'],
      cluster: ENV['PUSHER_APP_CLUSTER'],
      encrypted: true
    )
  end
end
