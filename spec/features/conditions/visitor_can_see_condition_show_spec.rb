require 'rails_helper'

describe 'visitor visits conditions#index' do
  scenario 'it shows all the attributes' do
    condition = create(:condition)

    visit condition_path(condition)

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
