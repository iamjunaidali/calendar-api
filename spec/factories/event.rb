FactoryBot.define do
  factory :event do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    start_date { "2021-02-10T02:06:00" }
    end_date { "2021-02-10T04:06:00" }
    is_notification { false }
  end
end
