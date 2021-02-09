class Event < ApplicationRecord
  searchable do
    time  :start_date
    time  :end_date
  end
end
