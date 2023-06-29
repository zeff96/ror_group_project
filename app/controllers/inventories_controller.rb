class InventoriesController < ApplicationController
  def index
    @inventories = Inventory.all
  end

  def show
    @inventory = Inventory.includes(:inventory_foods).find(params[:id])
    @inventory_id = @inventory.id
    @inventories = Inventory.all

    render :show
  end

  def new
    @inventory = Inventory.new
  end

  def create
    @inventory = Inventory.new(inventory_params)

    respond_to do |format|
      if @inventory.save
        format.html { redirect_to inventory_path(@inventory), notice: 'Inventory created succesfully!' }
        format.json { render :show, status: :created, location: @inventory }
      else
        format.html { redirect_to new_inventory_path, alert: 'Inventory not created!' }
        format.json { render json: @inventory.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @inventory = Inventory.find(params[:id])
    if @inventory.destroy
      flash[:notice] = 'Inventory deleted successfully!'
    else
      flash[:alert] = 'Inventory not deleted!'
    end
    redirect_to recipes_path
  end

  def shopping_list
    recipe_id = params[:recipe_id]
    params[:inventory_id]

    @inventory = recipe_id
  end

  private

  def inventory_params
    params.require(:inventory).permit(:name, :cooking_time, :preparation_time, :description, :status, :user_id)
  end
end
