require 'rails_helper'

describe 'As a Visitor' do
  context 'When I visit "/bike-shop"' do
    before(:each) do
      @accessories = create_list(:accessory, 12)
    end
    scenario 'I see at least 12 bike accessories for sale' do
      visit '/bike-shop'
      
      @accessories.each do |accessory|
        expect(page).to have_content(accessory.title)
        expect(page).to have_content(accessory.description)
        expect(page).to have_content(accessory.price)
      end
    end
  end
end
