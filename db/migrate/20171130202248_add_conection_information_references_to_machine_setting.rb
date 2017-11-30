class AddConectionInformationReferencesToMachineSetting < ActiveRecord::Migration[5.1]
  def change
    add_reference :machine_settings, :conection_information, index: true, foreign_key: true
  end
end