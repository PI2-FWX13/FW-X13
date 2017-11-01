class ChangeIpToString < ActiveRecord::Migration[5.1]
  def change
    change_column :conection_informations, :ip, :string

  end
end
