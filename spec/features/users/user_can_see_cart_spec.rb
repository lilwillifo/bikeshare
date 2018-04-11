require 'rails_helper'

describe 'A logged in user' do
  before(:each) do
    DatabaseCleaner.clean
    @user = create(:user)
    @accessories = create_list(:accessory, 3)
  end

  scenario 'can see their cart' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit accessories_path

    @accessories.each do |accessory|
      find(".add_accessory_#{accessory.id}").click
    end

    visit '/cart'

    @accessories.each do |accessory|
      expect(page).to have_content(accessory.title)
    end
  end

  scenario 'their cart is persisted if they were not yet logged in' do
    visit accessories_path

    @accessories.each do |accessory|
      find(".add_accessory_#{accessory.id}").click
    end

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit '/cart'

    @accessories.each do |accessory|
      expect(page).to have_content(accessory.title)
    end
  end
end