class AddColumnToFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :foods, :unit_quantity, :string
  end
end
