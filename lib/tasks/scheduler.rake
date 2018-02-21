desc "Restore dinosaurs"
task :restore_dinos => :environment do
  puts "Restoring dinos..."
  Dinosaur.restore
  puts "done."
end

desc "Return dinosaurs to random health, happiness, positivity"
task :randomize_dinos => :environment do
  puts "Randomizing dinos' health, happiness, positivity..."
  Dinosaur.randomize
  puts "done."
end
