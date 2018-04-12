require 'rails_helper'

describe 'admin visits conditions#index' do
  before(:each) do
    @admin = create(:admin)
    @conditions = create_list(:condition, 5)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  scenario 'it shows all the attributs' do
    visit conditions_path

    @conditions.each do |condition|
      expect(page).to have_content(condition.date)
      expect(page).to have_content(condition.max_temperature)
      expect(page).to have_content(condition.mean_temperature)
      expect(page).to have_content(condition.min_temperature)
      expect(page).to have_content(condition.mean_humidity)
      expect(page).to have_content(condition.mean_visibility)
      expect(page).to have_content(condition.mean_wind_speed)
      expect(page).to have_content(condition.precipitation)
    end
  end
end
