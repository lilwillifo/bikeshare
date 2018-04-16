require 'rails_helper'

describe 'As an admin' do
  describe 'When I visit an individual order page' do
    scenario 'I see the order details for an individual, including the full name and address' do
      admin = create(:admin)
      order = create(:order)
      accessory = create(:accessory)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit admin_order_path(order)
      
      save_and_open_page

      expect(page).to have_content(order.user.full_name)
      expect(page).to have_content(order.user.address)
      expect(page).to have_content(accessory.title)
      expect(page).to have_content(order.order_accessories.first.quantity)
    end
  end
end
