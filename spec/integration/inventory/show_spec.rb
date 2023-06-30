require 'rails_helper'

RSpec.describe 'Inventory', type: :feature do
  let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }

  before :each do
    user.confirm

    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    @inventory = Inventory.create(user:, name: 'test inventory1',
                                  description: 'test test1')

    visit "/inventories/#{@inventory.id}"
  end

  describe 'inventory show page' do
    it 'Inventory content' do
      expect(page).to have_content('test inventory1')
    end

    it 'When I click on a Add Food btn, I am redirected to Add Food page.' do
      click_link 'Add Food'
      expect(page).to have_current_path(new_inventory_inventory_food_path(@inventory))
    end

    it 'click on a toggle btn.' do
      check('toggle-btn')
      expect(page).to have_checked_field('toggle-btn')
    end
  end
end
