class ChangeIpToString < ActiveRecord::Migration[5.1]
  def change
    change_column :machine_informations, :ip, :string

  end
end
