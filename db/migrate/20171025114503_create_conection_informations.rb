class CreateConectionInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :conection_informations do |t|
      t.string :name
      t.string :ip
      t.string :wifi_name
      t.string :password
      t.timestamps
    end
  end
end
