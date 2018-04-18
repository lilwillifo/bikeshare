require 'rails_helper'

describe 'visitor visits conditions#index' do
  scenario 'it shows all the attributes' do
    conditions = create_list(:condition, 5)

    visit conditions_path

    conditions.each do |condition|
      expect(page).to have_content(condition.date.strftime('%d %B %Y'))
      expect(page).to have_content(condition.max_temperature)
      expect(page).to have_content(condition.mean_temperature)
      expect(page).to have_content(condition.min_temperature)
      expect(page).to have_content(condition.mean_humidity)
      expect(page).to have_content(condition.mean_visibility)
      expect(page).to have_content(condition.mean_wind_speed)
      expect(page).to have_content(condition.precipitation)
    end
  end

  scenario 'it can link from the show page' do
    condition = create(:condition)

    visit condition_path(condition)

    click_link '<< Back to Condition Index'

    expect(current_path).to eq(conditions_path)
  end
end
