class CreateWindings < ActiveRecord::Migration[5.1]
  def change
    create_table :windings do |t|
      t.float :length
      t.float :radius
      t.float :offset
      t.float :filamentWidth
      t.float :filamentLength
      t.float :gelPot
      t.float :density
      t.integer :layers
      t.float :angle
      t.datetime :windingdate
      t.string :winding_type

      t.timestamps
    end
  end
end
