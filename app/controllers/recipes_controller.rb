class RecipesController < ApplicationController
  load_and_authorize_resource

  def index
    @recipes = Recipe.all
  end

  def show
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
    @recipe_id = @recipe.id
    @inventories = Inventory.all

    render :show
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_path(@recipe), notice: 'Recipe created succesfully!' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, alert: 'Recipe not created!' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    if @recipe.destroy
      flash[:notice] = 'Recipe deleted successfully!'
    else
      flash[:alert] = 'Recipe not deleted!'
    end
    redirect_to recipes_path
  end

  def shopping_list
    @recipe_id = params[:recipe_id]
    @inventory_id = params[:inventory_id]

    @recipe = Recipe.includes(recipe_foods: :food).find(@recipe_id)
    @inventory = Inventory.find(@inventory_id)

    inventory_foods_id = @inventory.foods.pluck(:id)
    @missing_foods = @recipe.recipe_foods.reject { |food_recipe| inventory_foods_id.include?(food_recipe.food_id) }
  end

  def update
    @recipe = Recipe.find(params[:id])

    flash[:alert] = 'Not updated!' unless @recipe.update(recipe_params)
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :preparation_time, :description, :public, :user_id)
  end
end
