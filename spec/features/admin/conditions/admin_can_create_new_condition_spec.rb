require 'rails_helper'

describe 'admin visits condition#new' do
  before(:each) do
    @admin = create(:admin)
  end

  describe 'shows all the attributs' do
    it 'for the creation of a new condition' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit new_admin_condition_path

      fill_in 'condition[date]', with: '2018-04-10'
      fill_in 'condition[max_temperature]', with: 88
      fill_in 'condition[mean_temperature]', with: 78
      fill_in 'condition[min_temperature]', with: 68
      fill_in 'condition[mean_humidity]', with: 80
      fill_in 'condition[mean_visibility]', with: 12
      fill_in 'condition[mean_wind_speed]', with: 8
      fill_in 'condition[precipitation]', with: 5
      click_on 'Create Condition'

      expect(current_path).to eq(condition_path(Condition.all.last))
      expect(page).to have_content('Weather condition for 04 10 2018 added!')
      expect(page).to have_content('2018-04-10')
      expect(page).to have_content('88')
      expect(page).to have_content('78')
      expect(page).to have_content('68')
      expect(page).to have_content('80')
      expect(page).to have_content('12')
      expect(page).to have_content('8')
      expect(page).to have_content('5')
    end
  end

  describe 'links from index' do
    it ' to add a new condition' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit conditions_path

      click_link 'Add a new condition'

      fill_in 'condition[date]', with: '2018-04-10'
      fill_in 'condition[max_temperature]', with: 88
      fill_in 'condition[mean_temperature]', with: 78
      fill_in 'condition[min_temperature]', with: 68
      fill_in 'condition[mean_humidity]', with: 80
      fill_in 'condition[mean_visibility]', with: 12
      fill_in 'condition[mean_wind_speed]', with: 8
      fill_in 'condition[precipitation]', with: 5
      click_on 'Create Condition'

      expect(current_path).to eq(condition_path(Condition.all.last))
      expect(page).to have_content('Weather condition for 04 10 2018 added!')
      expect(page).to have_content('2018-04-10')
      expect(page).to have_content('88')
      expect(page).to have_content('78')
      expect(page).to have_content('68')
      expect(page).to have_content('80')
      expect(page).to have_content('12')
      expect(page).to have_content('8')
      expect(page).to have_content('5')
    end
  end

  describe 'as normal user' do
    it 'does not allow default user to take delete path' do
      user = User.create(username: 'fern@gully.com',
                         password: 'password')

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit new_admin_condition_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end

  describe 'as visitor' do
    it 'does not allow visitor to take delete path' do

      visit new_admin_condition_path
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
