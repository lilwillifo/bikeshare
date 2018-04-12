require 'rails_helper'

describe 'As a visitor' do
  before :each do
    @accessory = create(:accessory)
    visit accessories_path

    click_on 'Add to Cart'

    visit accessories_path
    click_on 'Add to Cart'

    visit accessories_path
    click_on 'Add to Cart'

    visit accessories_path
    click_on 'Add to Cart'

  end

  describe 'When I visit /cart' do
    scenario 'I can see a thumbnail for each accessory as well as title and price' do
      expect(page).to have_content(@accessory.title)
      expect(page).to have_content(@accessory.description)
      expect(page).to have_content("$5.00")
    end

    scenario 'I can see a subtotal and quantity breakdown for each accessory' do
      expect(page).to have_content("Subtotal: $20.00")
      expect(page).to have_content("Quantity: 4")
    end

    scenario 'I can see a total for my cart' do
      expect(page).to have_content("Total: $20.00")
    end
  end
end
