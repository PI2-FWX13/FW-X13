class AddDataToWinding < ActiveRecord::Migration[5.1]
  def change
    add_column :windings, :projectName, :string
  end
end
