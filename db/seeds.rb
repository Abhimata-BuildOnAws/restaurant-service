# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


res = Restaurant.create(email: 'aikarvin99@gmail.com', name: 'Mise la Arvin', address: 'Hells Kitchen', contact_no: '12345678', password: '1234')
food1 = MenuItem.create(name: 'Orange chicken', description: 'Its just orange chicken', price: 4.5, restaurant_id: res.id)
food2 = MenuItem.create(name: 'Blue chicken', description: 'Its blue chicken', price: 5.5, restaurant_id: res.id)