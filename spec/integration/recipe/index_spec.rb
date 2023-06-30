require 'rails_helper'

RSpec.describe 'Recipe recipe index page', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  before do
    user.confirm

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    @recipe = Recipe.create(user:, name: 'test recipe1', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                            description: 'test test1', public: true)
    @recipe1 = Recipe.create(user:, name: 'test recipe2', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                             description: 'test test2', public: true)

    visit '/recipes'
  end

  it 'displays the list of recipes' do
    expect(page).to have_content('test recipe1')
    expect(page).to have_content('test test1')
  end
end
