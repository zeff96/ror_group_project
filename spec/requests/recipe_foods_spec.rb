require 'rails_helper'

RSpec.describe RecipeFood, type: :request do
  describe 'POST :create' do
    before do
      @user = User.create(name: 'test', email: 'test2@example.com', password: 'password')
      @user.confirm
      sign_in @user
      @recipe = Recipe.create(user: @user, name: 'test recipe',
                              preparation_time: '1 Hr',
                              cooking_time: '1.5 hrs',
                              description: 'test description',
                              public: true)
      @test_food = Food.create(name: 'test food', measurement_unit: 2, price: 10, unit_quantity: 'kgs')
    end
    it 'creates a new recipe_food' do
      recipe_attributes = { quantity: 20, food_id: @test_food.id, quantity_unit: 'kgs' }

      post recipe_recipe_foods_path(@recipe), params: { recipe_food: recipe_attributes }

      expect(response.status).to eq(302)
      expect(RecipeFood.count).to eq(1)
      expect(RecipeFood.last.quantity).to eq(20)
      expect(RecipeFood.last.recipe).to eq(@recipe)
      expect(RecipeFood.last.food).to eq(@test_food)
    end
  end
end
