class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.new(recipe_id: params[:recipe_id])
    @foods = Food.all
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = @recipe.recipe_foods.build(recipe_food_params)
  
    if @recipe_food.save
      flash[:notice] = 'Food linked to recipe successfully!'
      redirect_to recipe_path(@recipe)
    else
      @food = Food.all
      render :new
    end
  end

  def recipe_food_params
    params.require(:recipe_food).permit(:recipe_id, :food_id, :quantity)
  end
end
