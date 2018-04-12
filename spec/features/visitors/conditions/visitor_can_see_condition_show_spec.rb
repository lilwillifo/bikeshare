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

  scenario 'it can link from the index page' do
    condition = create(:condition)

    visit conditions_path

    click_link condition.id

    expect(current_path).to eq(condition_path(condition))
  end
end
