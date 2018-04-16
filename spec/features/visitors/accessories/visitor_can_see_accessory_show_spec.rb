require 'rails_helper'

describe 'As a Visitor' do
  context 'When I visit an accessory show page' do
    scenario 'I see details for that accessory' do
      accessories = create_list(:accessory, 2)

      visit accessory_path(accessories[1])

      expect(page).to have_xpath("//img[contains(@src,'https://17a6ky3xia123toqte227ibf-wpengine.netdna-ssl.com/wp-content/uploads/2016/12/bike-home-template-optimized.jpg')]")
      expect(page).to have_content(accessories[1].title)
      expect(page).to have_content(accessories[1].description)
      expect(page).to have_content(accessories[1].price)
      expect(page).to have_button('Add to Cart')
    end
  end
end
