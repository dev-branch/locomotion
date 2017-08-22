class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars do |t|
      t.string :make, null: false
      t.string :model, null: false
      t.string :year, null: false
      t.string :vin, null: false
      t.string :color
      t.string :category
      t.integer :cylinders
      t.integer :mpg
      t.integer :hp
      t.timestamps
    end

    add_index :cars, [:vin], unique: true
    add_index :cars, [:make, :model, :year], unique: true
  end
end
