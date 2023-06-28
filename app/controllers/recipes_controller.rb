class RecipesController < ApplicationController
	def index
		@recipes = Recipe.all
	end

	def show
		@recipe = Recipe.find(params[:id])
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
				format.html { redirect_to new_recipe_path, alert: 'Recipe not created!' }
				format.json { render json: @recipe.errors, status: :unprocessable_entity }
			end
		end
	end

	def destroy
		@recipe = Recipe.find(params[:id])
		if @recipe.destroy
			flash[:notice] = 'Recipe deleted successfully!'
			redirect_to recipes_path
		else
			flash[:alert] = 'Recipe not deleted!'
			redirect_to recipes_path
		end
	end

	private

	def recipe_params
		params.require(:recipe).permit(:name, :cooking_time, :preparation_time, :description, :status, :user_id)
	end
end
