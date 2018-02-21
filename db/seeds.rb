# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

species = ["Velociraptor", "Allosaurus", "Iguanodon", "Ankylosaurus", "Brachiosaurus"]

species.each do |s|
  Dinosaur.create(species:s, health:rand(0..100), happiness:rand(0..100), radiating_positivity:rand(0..100))
end
