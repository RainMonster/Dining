# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

user1 = RegularUser.new(first_name: 'Sally', last_name: 'Hallifax', email: 'test@email.com', user_type: "Host")
user1.password = "password"
user1.password_confirmation = "password"
user1.save
user2 = RegularUser.new(first_name: 'Richard', last_name: 'Kent', email: 'test2@email.com', user_type: "Host")
user2.password = "password"
user2.password_confirmation = "password"
user2.save
Event.create(user_id: 1, neighborhood: "Dogpatch", region: "san_francisco", restaurant_name: "Hard Knox Cafe", description: "Delicious food", RSVP_deadline: (Time.now - 9999991), event_time: (Time.now + 9999997))
Event.create(user_id: 2, neighborhood: "Mission", region: "san_francisco", restaurant_name: "Mamacita's", description: "tacos", RSVP_deadline: (Time.now + 9999992), event_time: (Time.now + 9999998))
Event.create(user_id: 1, neighborhood: "Chinatown", region: "san_francisco", restaurant_name: "Sushiritto", description: "sushi burritos", RSVP_deadline: (Time.now + 9999993), event_time: (Time.now + 9999994))
Event.create(user_id: 1, neighborhood: "Financial District", region: "san_francisco", restaurant_name: "The Plant", description: "Healthy food", RSVP_deadline: (Time.now + 9999994), event_time: (Time.now + 9999995))
Event.create(user_id: 1, neighborhood: "Berkeley", region: "east_bay", restaurant_name: "Bartavelle", description: "home-made pickles", RSVP_deadline: (Time.now + 9999995), event_time: (Time.now + 9999996))
Event.create(user_id: 2, neighborhood: "Oakland", region: "east_bay", restaurant_name: "Elixir", description: "Upscale bar", RSVP_deadline: (Time.now + 9999996), event_time: (Time.now + 9999997))
