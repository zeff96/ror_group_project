class RecipeFoodsController < ApplicationController
  def new_food
    @recipe_food = RecipeFoods.new(recipe_id: params[:recipe_id], food_id: params[:food_id], quantity: params[:food][:quantity])
    @recipe_food.save

    render :new_food
  end
end
