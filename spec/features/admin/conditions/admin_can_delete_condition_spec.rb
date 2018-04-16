require 'rails_helper'

describe 'admin visits condition#new' do
  before(:each) do
    @admin = create(:admin)
    @condition = create(:condition)
  end

  describe 'can link from index page' do
    it 'to delete a condition' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit conditions_path

      within(".condition_#{@condition.id}") do
        find(:xpath, ".//a[i[contains(@class, 'fas fa-trash-alt')]]").click
      end

      expect(current_path).to eq(conditions_path)
      expect(page).to have_content('Weather condition for 10 04 2002 deleted!')
      expect(page).to_not have_content(@condition.date)
      expect(page).to_not have_content(@condition.max_temperature)
      expect(page).to_not have_content(@condition.mean_temperature)
      expect(page).to_not have_content(@condition.min_temperature)
      expect(page).to_not have_content(@condition.mean_humidity)
      expect(page).to_not have_content(@condition.mean_visibility)
      expect(page).to_not have_content(@condition.mean_wind_speed)
      expect(page).to_not have_content(@condition.precipitation)
    end
  end

  describe 'can link from index page' do
    it 'to delete a condition' do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)

      visit condition_path(@condition)

      find(:xpath, ".//a[i[contains(@class, 'fas fa-trash-alt')]]").click

      expect(current_path).to eq(conditions_path)
      expect(page).to have_content('Weather condition for 10 04 2002 deleted!')
      expect(page).to_not have_content(@condition.date)
      expect(page).to_not have_content(@condition.max_temperature)
      expect(page).to_not have_content(@condition.mean_temperature)
      expect(page).to_not have_content(@condition.min_temperature)
      expect(page).to_not have_content(@condition.mean_humidity)
      expect(page).to_not have_content(@condition.mean_visibility)
      expect(page).to_not have_content(@condition.mean_wind_speed)
      expect(page).to_not have_content(@condition.precipitation)
    end
  end
end
