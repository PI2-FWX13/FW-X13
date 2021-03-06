class CreateWindings < ActiveRecord::Migration[5.1]
  def change
    create_table :windings do |t|
      t.float :length
      t.float :radius
      t.float :offset
      t.float :filament_width
      t.float :filament_length
      t.float :gelPot
      t.float :density
      t.integer :layers
      t.float :angle
      t.time :winding_date
      t.string :winding_type
      t.time :estimated_time

      t.timestamps
    end
  end
end
