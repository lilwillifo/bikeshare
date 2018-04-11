require 'rails_helper'

describe 'As a visitor' do
  describe 'When I visit an accessory show for a retired accessory' do
    before(:each) do
      @accessory = create(:accessory, role: 1)
    end

    scenario 'I am still able to access the accessory page' do
      visit "bike-shop/#{@accessory.id}"

      expect(page).to have_content(@accessory.title)
      expect(page).to have_content(@accessory.description)
      expect(page).to have_content(@accessory.price)
    end

    scenario 'I am not able to add the accessory to my cart,and I see "Accessory Retired"' do
      visit "bike-shop/#{@accessory.id}"

      expect(page).to have_content("Accessory Retired")
      expect(page).to_not have_button('Add To Cart')
    end
  end
end
