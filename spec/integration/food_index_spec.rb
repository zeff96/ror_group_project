require 'rails_helper'

RSpec.describe 'Foods', type: :feature do
  describe 'Food list index page' do
    let!(:user) { User.create(name: 'Test', email: 'test2@example.com', password: 'password') }
    before do
      user.confirm
      visit new_user_session_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Log in'
      @food1 = Food.create(name: 'Jolof', measurement_unit: 2, unit_quantity: 'kg', price: 50)
      @food = Food.create(name: 'Fish', measurement_unit: 3, unit_quantity: 'kg', price: 100)
      visit '/foods'
    end

    it 'A food list is displayed on the foods page' do
      expect(page).to have_content('Jolof')
      expect(page).to have_content('Fish')
    end
    it 'A food measurement is displayed on the foods page' do
      expect(page).to have_content('2.0')
      expect(page).to have_content('3.0')
    end
    it 'A food price is displayed on the foods page' do
      expect(page).to have_content("$#{@food1.measurement_unit * @food1.price}")
      expect(page).to have_content("$#{@food.measurement_unit * @food.price}")
    end
  end
end
