require 'rails_helper'

describe 'As a Visitor' do
  describe 'When I visit cart_path' do
    context 'I decrease the quantity of an accessory in the cart' do
      scenario 'I see the quantity for that accessory decrease' do
        accessories = create_list(:accessory, 2)
        accessory = accessories[1]

        visit accessories_path

        within(".accessory_#{accessory.id}") do
          click_on 'Add to Cart'
          click_on 'Add to Cart'
        end

        expect(page).to have_content(accessory.title)
        expect(page).to have_content(accessory.description)
        expect(page).to have_content(accessory.price)

        find(".decrease_quantity_#{accessories[1].id}").click

        expect(current_path).to eq(cart_path)
        expect(page).to have_content("Subtotal: $5.00")
        expect(page).to have_content("Quantity: 1")
        expect(page).to have_content("Total: $5.00")
      end
    end
  end
end
