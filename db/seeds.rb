# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'

User.destroy_all
City.destroy_all
Gossip.destroy_all
Tag.destroy_all
PrivateMessage.destroy_all
MessageRecipient.destroy_all
Like.destroy_all


10.times do |city|
  City.create(name: Faker::Address.city, zip_code: Faker::Address.zip_code)
end

10.times do |user|
  User.create(first_name: Faker::Name.unique.first_name, last_name: Faker::Name.last_name, description: Faker::Movies::HarryPotter.house , email: Faker::Internet.email , age: rand(21..100) , city_id: City.all.sample.id, password: "test")
end

10.times do |gossip|
  Gossip.create(title: Faker::Movies::StarWars.planet, content: Faker::Movies::StarWars.quote, user_id: User.all.sample.id )
end

10.times do |tag|
  Tag.create(title: Faker::Games::Pokemon.move)
end

10.times do |gossiptag|
  GossipTag.create(gossip_id: Gossip.all.sample.id, tag_id: Tag.all.sample.id)
end

20.times do |like|
	Like.create(user: User.all.sample, gossip: Gossip.all.sample)
end