class CreateMachineSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :machine_settings do |t|
      t.integer :maximum_offset
      t.integer :maximum_size_mandril
      t.integer :maximum_size_radius

      t.timestamps
    end
  end
end
