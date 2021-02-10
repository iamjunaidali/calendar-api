class Event < ApplicationRecord
  CHANNELS_MAP = {
    notifications: 'notifications'
  }.freeze

  EVENTS_MAP = {
    reminder: 'reminder'
  }.freeze

  searchable do
    time  :start_date
    time  :end_date
  end
end
