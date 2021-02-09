FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    start_date { DateTime.current }
    end_date { start_date + 30.minutes}
    is_notification { false }
  end
end
