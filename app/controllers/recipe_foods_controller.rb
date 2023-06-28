class RecipeFoodsController < ApplicationController
  def new_food
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find(params[:food_id])
    @recipe_food = RecipeFood.new(recipe: @recipe, food: @food)
  end

  def create_food
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find(params[:food_id])
    @recipe_food = RecipeFood.new(recipe: @recipe, food: @food, quantity: params[:food][:quantity])
  
    if @recipe_food.save
      redirect_to recipe_path(@recipe)
    else
      render :new_food
    end
  end
end
