# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Faker::Config.locale = :ja


50.times do
  users = User.create(name: Faker::Name.name,
                      email: Faker::Internet.email,
                      password_digest: 'test')
end

500.times do
  tasks = Task.create(name: Faker::Pokemon.name,
                      detail: Faker::Pokemon.location,
                      priority: Random.new.rand(0..3),
                      status: Random.new.rand(0..2),
                      end_date: Date.today + Random.new.rand(1..500),
                      user_id: Random.new.rand(1..50))
end
