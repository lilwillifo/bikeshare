require 'rails_helper'

describe 'admin visits condition#new' do
  before(:each) do
    @admin = create(:admin)
    @condition = create(:condition)
    @condition2 = create(:condition)
    @condition3 = create(:condition)
  end

  describe 'shows all the attributs' do
    it 'for the update of a condition' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit edit_admin_condition_path(@condition)

      fill_in 'condition[date]', with: '2018-04-10'
      fill_in 'condition[max_temperature]', with: 88
      fill_in 'condition[mean_temperature]', with: 78
      fill_in 'condition[min_temperature]', with: 68
      fill_in 'condition[mean_humidity]', with: 80
      fill_in 'condition[mean_visibility]', with: 12
      fill_in 'condition[mean_wind_speed]', with: 8
      fill_in 'condition[precipitation]', with: 5
      click_on 'Update Condition'

      expect(current_path).to eq(condition_path(@condition))
      expect(page).to have_content('Weather conditions for 04 10 2018 updated!')
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

  describe 'can link from index page' do
    it 'to update a condition' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit conditions_path

      within(".condition_#{@condition.id}") do
        find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click
      end

      fill_in 'condition[date]', with: '2018-04-10'
      fill_in 'condition[max_temperature]', with: 88
      fill_in 'condition[mean_temperature]', with: 78
      fill_in 'condition[min_temperature]', with: 68
      fill_in 'condition[mean_humidity]', with: 80
      fill_in 'condition[mean_visibility]', with: 12
      fill_in 'condition[mean_wind_speed]', with: 8
      fill_in 'condition[precipitation]', with: 5
      click_on 'Update Condition'

      expect(current_path).to eq(condition_path(@condition))
      expect(page).to have_content('Weather conditions for 04 10 2018 updated!')
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

  describe 'can link from index page' do
    it 'to update a condition' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit condition_path(@condition)

      find(:xpath, ".//a[i[contains(@class, 'far fa-edit')]]").click

      fill_in 'condition[date]', with: '2018-04-10'
      fill_in 'condition[max_temperature]', with: 88
      fill_in 'condition[mean_temperature]', with: 78
      fill_in 'condition[min_temperature]', with: 68
      fill_in 'condition[mean_humidity]', with: 80
      fill_in 'condition[mean_visibility]', with: 12
      fill_in 'condition[mean_wind_speed]', with: 8
      fill_in 'condition[precipitation]', with: 5
      click_on 'Update Condition'

      expect(current_path).to eq(condition_path(@condition))
      expect(page).to have_content('Weather conditions for 04 10 2018 updated!')
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
end
