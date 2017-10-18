class CreateMachineSettings < ActiveRecord::Migration[5.1]
  def change
    create_table :machine_settings do |t|
      t.integer :offset
      t.integer :maximum_size_mandril
      t.integer :size_radius

      t.timestamps
    end
  end
end
