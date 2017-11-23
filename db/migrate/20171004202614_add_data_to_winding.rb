class AddDataToWinding < ActiveRecord::Migration[5.1]
  def change
    add_column :windings, :project_name, :string
  end
end
