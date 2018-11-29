# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Movie.create(
  title: 'Deadly Weapon',
  description: '2 retired monks walk into a bar',
  reviews: [Review.create(content: "This was a cool movie!")],
)

Movie.create(
  title: 'Deadly Weapon 2 — This time time it’s personal',
  description: 'Like Deadly Weapon, only deadlier and more personal',
  reviews: [Review.create(content: "This was an even cooler movie!")],
)
