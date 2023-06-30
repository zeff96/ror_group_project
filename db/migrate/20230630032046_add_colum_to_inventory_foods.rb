class AddColumToInventoryFoods < ActiveRecord::Migration[7.0]
  def change
    add_column :inventory_foods, :quantity_unit, :string
  end
end
