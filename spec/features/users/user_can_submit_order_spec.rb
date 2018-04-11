require 'rails_helper'

describe 'A logged in user' do
  before(:each) do
    DatabaseCleaner.clean
    @user = create(:user)
    @accessories = create_list(:accessory, 3)
  end

  scenario 'can checkout from cart' do
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)

    visit accessories_path

    @accessories.each do |accessory|
      find(".add_accessory_#{accessory.id}").click
    end

    visit '/cart'

    click_on 'Checkout'

    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Successfully submitted your order totaling $15.00')
  end
end
