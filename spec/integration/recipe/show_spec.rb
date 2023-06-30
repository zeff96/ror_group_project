require 'rails_helper'

RSpec.describe 'Recipe', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  before :each do
    user.confirm

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    @recipe = Recipe.create(user:, name: 'test recipe1', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                            description: 'test test1', public: true)

    visit "/recipes/#{@recipe.id}"
  end

  describe 'recipe show page' do
    it 'Recipe content' do
      expect(page).to have_content('test recipe1')
      expect(page).to have_content("Preparation Time: #{@recipe.preparation_time}")
      expect(page).to have_content("Cooking Time: #{@recipe.cooking_time}")
    end

    it 'When I click on a Add Inrgredient btn, I am redirected to Add ingredient page.' do
      click_link 'Add ingredient'
      expect(page).to have_current_path(new_recipe_recipe_food_path(@recipe))
    end

    it 'click on a toggle btn.' do
      check('toggle-btn')
      expect(page).to have_checked_field('toggle-btn')
    end
  end
end
