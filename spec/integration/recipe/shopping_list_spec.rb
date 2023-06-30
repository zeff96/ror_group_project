require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  describe 'recipe show page' do
    before do
      user.confirm

      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'

      @recipe = Recipe.create(user:, name: 'test recipe1', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                              description: 'test test1', public: true)
      @test_food = Food.create(name: 'test food', measurement_unit: 2, price: 10, unit_quantity: 'kgs')
      @inventory = Inventory.create(name: 'Inventoy 1', description: 'test test', user:)
      @recipe_food = RecipeFood.create(quantity: 10, quantity_unit: 'kgs', food: @test_food, recipe: @recipe)

      visit shopping_list_path(recipe_id: @recipe.id, inventory_id: @inventory.id)
    end
    it 'Shoping list content' do
      expect(page).to have_content('Shopping List')
      expect(page).to have_content('Amount of food to buy: 1')
    end
  end
end
