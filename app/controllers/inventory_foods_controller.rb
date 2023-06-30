class InventoryFoodsController < ApplicationController
  def new
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = InventoryFood.new(inventory_id: params[:inventory_id])
    @foods = Food.all
  end

  def create
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = @inventory.inventory_foods.build(inventory_food_params)

    if @inventory_food.save
      flash[:notice] = 'Food linked to inventory successfully!'
      redirect_to inventory_path(@inventory)
    else
      @food = Food.all
      render :new
    end
  end

  def destroy
    @inventory = Inventory.find(params[:inventory_id])
    @inventory_food = InventoryFood.find(params[:id])
    @inventory_food.destroy
    flash[:notice] = 'inventory food deleted successfully!'
    redirect_to inventory_path(@inventory)
  end

  def inventory_food_params
    params.require(:inventory_food).permit(:inventory_id, :food_id, :quantity, :quantity_unit)
  end
end
