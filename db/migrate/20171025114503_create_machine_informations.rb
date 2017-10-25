class CreateMachineInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :machine_informations do |t|
      t.string :name
      t.integer :ip

      t.timestamps
    end
  end
end
