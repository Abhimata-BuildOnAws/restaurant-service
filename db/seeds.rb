# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# res = Restaurant.create(email: 'aikarvin@gmail.com', name: 'Mise en Place', street: '12 Verde Avenue', state: 'Singapore', country: 'Singapore', contact_no: '12345678')
# food1 = MenuItem.create(name: 'Orange chicken', description: 'Its just orange chicken', price: 4.5, restaurant_id: res.id)
# food2 = MenuItem.create(name: 'Blue chicken', description: 'Its blue chicken', price: 5.5, restaurant_id: res.id)
res0 = Restaurant.create(email: 'aikarvi99n@gmail.com', name: 'Fortune Centre', street: '190 Middle Rd', state: 'Singapore', country: 'Singapore', contact_no: '12345678')
res1 = Restaurant.create(email: 'aikarvin@yahoo.com.sg', name: 'Sunshine Plaza', street: '91 Bencoolen St', state: 'Singapore', country: 'Singapore', contact_no: '12345678')
res2 = Restaurant.create(email: 'pbeebsandj@gmail.com', name: 'Bugis Junction', street: '200 Victoria St', state: 'Singapore', country: 'Singapore', contact_no: '12345678')
res3 = Restaurant.create(email: 'arvin.aik.2020@sis.smu.edu.sg', name: 'Funan', street: '107 North Bridge Rd', state: 'Singapore', country: 'Singapore', contact_no: '12345678')
res4 = Restaurant.create(email: 'arvin.aik.2020@smu.edu.sg', name: 'Raffles City', street: '252 North Bridge Rd', state: 'Singapore', country: 'Singapore', contact_no: '12345678')

puts "#{Restaurant.count} restaurants seeded"


food00 = MenuItem.create(name: 'Red fish', description: 'Its just red fish', price: 3.5, restaurant_id: res0.id)
food01 = MenuItem.create(name: 'Orange chicken', description: 'Its just orange chicken', price: 4.5, restaurant_id: res0.id)
food02 = MenuItem.create(name: 'Blue chicken', description: 'Its blue chicken', price: 5.5, restaurant_id: res0.id)
food03 = MenuItem.create(name: 'Yellow cod', description: 'Its just yellow cod', price: 4.5, restaurant_id: res0.id)
food04 = MenuItem.create(name: 'Pink panther', description: 'Its pink panther', price: 6.5, restaurant_id: res0.id)

food10 = MenuItem.create(name: 'Red fish', description: 'Its just red fish', price: 3.5, restaurant_id: res1.id)
food11 = MenuItem.create(name: 'Orange chicken', description: 'Its just orange chicken', price: 4.5, restaurant_id: res1.id)
food12 = MenuItem.create(name: 'Blue chicken', description: 'Its blue chicken', price: 5.5, restaurant_id: res1.id)
food13 = MenuItem.create(name: 'Yellow cod', description: 'Its just yellow cod', price: 4.5, restaurant_id: res1.id)
food14 = MenuItem.create(name: 'Pink panther', description: 'Its pink panther', price: 6.5, restaurant_id: res1.id)

food20 = MenuItem.create(name: 'Red fish', description: 'Its just red fish', price: 3.5, restaurant_id: res2.id)
food21 = MenuItem.create(name: 'Orange chicken', description: 'Its just orange chicken', price: 4.5, restaurant_id: res2.id)
food22 = MenuItem.create(name: 'Blue chicken', description: 'Its blue chicken', price: 5.5, restaurant_id: res2.id)
food23 = MenuItem.create(name: 'Yellow cod', description: 'Its just yellow cod', price: 4.5, restaurant_id: res2.id)
food24 = MenuItem.create(name: 'Pink panther', description: 'Its pink panther', price: 6.5, restaurant_id: res2.id)

food30 = MenuItem.create(name: 'Red fish', description: 'Its just red fish', price: 3.5, restaurant_id: res3.id)
food31 = MenuItem.create(name: 'Orange chicken', description: 'Its just orange chicken', price: 4.5, restaurant_id: res3.id)
food32 = MenuItem.create(name: 'Blue chicken', description: 'Its blue chicken', price: 5.5, restaurant_id: res3.id)
food33 = MenuItem.create(name: 'Yellow cod', description: 'Its just yellow cod', price: 4.5, restaurant_id: res3.id)
food34 = MenuItem.create(name: 'Pink panther', description: 'Its pink panther', price: 6.5, restaurant_id: res3.id)

food40 = MenuItem.create(name: 'Red fish', description: 'Its just red fish', price: 3.5, restaurant_id: res4.id)
food41 = MenuItem.create(name: 'Orange chicken', description: 'Its just orange chicken', price: 4.5, restaurant_id: res4.id)
food42 = MenuItem.create(name: 'Blue chicken', description: 'Its blue chicken', price: 5.5, restaurant_id: res4.id)
food43 = MenuItem.create(name: 'Yellow cod', description: 'Its just yellow cod', price: 4.5, restaurant_id: res4.id)
food44 = MenuItem.create(name: 'Pink panther', description: 'Its pink panther', price: 6.5, restaurant_id: res4.id)

puts "#{MenuItem.count} menu items seeded"

# hitch0 = Hitch.create(pickup: '190 Middle Rd', user: user0, restaurant_id: res0.id, submit_time: DateTime.iso8601("2021-07-21T14:40:06+08:00"))
# hitch1 = Hitch.create(pickup: '25 Bencoolen St', user: user1, restaurant_id: res1.id, submit_time: DateTime.iso8601("2021-07-21T14:40:06+08:00"))
# hitch2 = Hitch.create(pickup: '13 Verde Ave', user: user2, restaurant_id: res2.id, submit_time: DateTime.iso8601("2021-07-21T14:40:06+08:00"))

# puts "#{Hitch.count} hitches seeded"
# hitch3 = Hitch.create(pickup: '7 Orange Grove Rd')
