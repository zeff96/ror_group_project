require 'rails_helper'

RSpec.describe 'Inventory  index page', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  before do
    user.confirm

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    @inventory = Inventory.create(user:, name: 'test inventory1',
                                  description: 'test test1')
    @inventory1 = Inventory.create(user:, name: 'test inventory2',
                                   description: 'test test2')

    visit '/inventories'
  end

  it 'displays the list of inventories' do
    expect(page).to have_content('test inventory1')
    expect(page).to have_content('test test1')
  end
end
