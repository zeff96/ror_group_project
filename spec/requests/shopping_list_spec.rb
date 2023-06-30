require 'rails_helper'

RSpec.describe 'Shopping list', type: :request do
  describe 'GET /shopping_list' do
    before do
      @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
      @user.confirm
      sign_in @user
    end

    it 'responds with success' do
      recipe = Recipe.create(user: @user, name: 'test recipe', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                             description: 'test description', public: true)
      inventory = Inventory.create(name: 'Inventoy 1', description: 'test test', user: @user)
      get shopping_list_path(recipe_id: recipe.id, inventory_id: inventory.id)
      expect(response).to have_http_status(:success)
    end

    it 'responds with correct status' do
      recipe = Recipe.create(user: @user, name: 'test recipe', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                             description: 'test description', public: true)
      inventory = Inventory.create(name: 'Inventoy 1', description: 'test test', user: @user)
      get shopping_list_path(recipe_id: recipe.id, inventory_id: inventory.id)
      expect(response.status).to eq(200)
    end

    it 'renders the shopping_list template' do
      recipe = Recipe.create(user: @user, name: 'test recipe', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                             description: 'test description', public: true)
      inventory = Inventory.create(name: 'Inventoy 1', description: 'test test', user: @user)
      get shopping_list_path(recipe_id: recipe.id, inventory_id: inventory.id)
      expect(response).to render_template('shopping_list')
    end
  end
end
