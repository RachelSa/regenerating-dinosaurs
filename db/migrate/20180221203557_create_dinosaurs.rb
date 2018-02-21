class CreateDinosaurs < ActiveRecord::Migration[5.1]
  def change
    create_table :dinosaurs do |t|
      t.string :species
      t.integer :health
      t.integer :happiness
      t.integer :radiating_positivity
      t.timestamps
    end
  end
end
