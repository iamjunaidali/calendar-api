# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..5).each do |i|
  Event.create({
  title: "Event-#{i}",
  description: "This is a test description-#{i}",
  start_date: DateTime.now,
  end_date: DateTime.now + 10.minutes,
  is_notification: false,
})
end
