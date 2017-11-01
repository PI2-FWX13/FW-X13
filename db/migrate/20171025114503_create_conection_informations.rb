class CreateConectionInformations < ActiveRecord::Migration[5.1]
  def change
    create_table :conection_informations do |t|
      t.string :name
      t.string :ip

      t.timestamps
    end
  end
end
