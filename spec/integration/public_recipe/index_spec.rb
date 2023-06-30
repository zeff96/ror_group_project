require 'rails_helper'

RSpec.describe 'User index page', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  before :each do
    user.confirm

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    recipe_attributes = {
      user_id: user.id,
      name: 'New public recipe',
      preparation_time: '1 hr',
      cooking_time: '1.5 hrs',
      description: 'Recipe description'
    }

    @recipe = Recipe.create!(recipe_attributes.merge(public: true))
    @recipe = Recipe.create!(recipe_attributes.merge(public: false))

    visit '/public_recipes'
  end

  describe 'Recipe' do
    scenario 'Public recipe is displayed on public_recipes page' do
      expect(page).to have_content('New public recipe')
    end

    scenario 'Private recipe is not displayed on public_recipes page' do
      expect(page).to_not have_content('New private recipe')
    end
  end
end
