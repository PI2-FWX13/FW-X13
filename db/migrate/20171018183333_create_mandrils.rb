class CreateMandrils < ActiveRecord::Migration[5.1]
  def change
    create_table :mandrils do |t|
      t.float   :compriment
      t.float   :radius
      t.string 	:mandril_type

      t.timestamps
    end
  end
end
