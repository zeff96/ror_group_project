require 'rails_helper'

RSpec.describe 'Inventory', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    @user.confirm
    sign_in @user
  end

  describe 'GET /inventories' do
    it 'should respond with success' do
      get '/inventories'
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      get '/inventories'
      expect(response).to render_template('index')
    end
  end

  describe 'GET /inventories/:id' do
    let(:inventory) do
      Inventory.create(user: @user, name: 'test inventory',
                       description: 'test description')
    end

    it 'should respond with success' do
      get inventory_path(recipe)
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      get inventory_path(recipe)
      expect(response).to render_template('show')
    end

    it 'should include recipe name in the response body' do
      get inventory_path(inventory)
      expect(response.body).to include('test inventory')
    end
  end

  describe 'POST /inventory' do
    it 'creates a new inventory' do
      expect do
        post '/inventory',
             params: { inventory: { name: 'New Inventory',
                                    description: 'New inventory description', user_id: @user.id } }
      end.to change { Inventory.count }.by(1)

      created_inventory = Inventory.last
      expect(created_inventory.name).to eq('New Inventory')
      expect(created_inventory.cooking_time).to eq('2 hrs')
      expect(created_inventory.preparation_time).to eq('1 hr')
      expect(created_inventory.description).to eq('New inventory description')
      expect(created_inventory.public).to be true
      expect(created_inventory.user_id).to eq(@user.id)
    end

    it 'redirects to the created inventory' do
      post '/inventories',
           params: { inventory: { name: 'New Inventory', cooking_time: '2 hrs', preparation_time: '1 hr',
                                  description: 'New inventory description', public: true, user_id: @user.id } }
      created_inventory = Inventory.last
      expect(response).to redirect_to(inventory_path(created_inventory))
    end
  end

  describe 'PATCH /inventories/:id' do
    let(:recipe) do
      Recipe.create(user_id: @user.id, name: 'test recipe', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                    description: 'test description', public: true)
    end
    let(:recipe_attributes) { { name: 'Updated Recipe' } }

    it 'updates recipe visibility' do
      patch recipe_path(recipe), params: { recipe: recipe_attributes }
      expect(response).to redirect_to(recipe_path(recipe))
      recipe.reload
      expect(recipe.name).to eq('Updated Recipe')
    end

    it 'handles invalid data' do
      patch recipe_path(recipe), params: { recipe: { name: '' } }
      expect(response).to redirect_to(recipe_path(recipe))
      recipe.reload
      expect(recipe.name).to eq('test recipe')
    end
  end

  describe 'DELETE /inventories/:id' do
    let!(:recipe) do
      Recipe.create(user: @user, name: 'test recipe', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                    description: 'test description', public: true)
    end

    it 'deletes a recipe' do
      expect do
        delete recipe_path(recipe)
      end.to change(Recipe, :count).by(-1)

      expect(response).to redirect_to(inventories_path)
    end
  end
end
