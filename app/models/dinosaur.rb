class Dinosaur < ApplicationRecord

  def self.restore
    dinosaurs = Dinosaur.update_all(health:100, happiness:100, radiating_positivity:100)
  end

  def self.randomize
    dinosaurs = Dinosaur.update_all(health:rand(0..100), happiness:rand(0..100), radiating_positivity:rand(0..100))
  end
end
