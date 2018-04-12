require 'rails_helper'

describe 'As a Visitor' do
  context 'When I visit "/bike-shop"' do
    before(:each) do
      @accessories = create_list(:accessory, 12)
    end

    scenario 'I see at least 12 bike accessories for sale' do
      visit accessories_path

      @accessories.each do |accessory|
        expect(page).to have_content(accessory.title)
        expect(page).to have_content(accessory.description)
        expect(page).to have_content(accessory.price)
      end
    end

    scenario 'I see a button near each item that says "Add to Cart"' do
      visit accessories_path

      @accessories.each do |accessory|
        within(".accessory_#{accessory.id}") do
          expect(page).to have_button('Add to Cart')
        end
      end
    end

    context 'When I click "Add to Cart"' do
      scenario 'I see a flash message alerting me that I have added that specific accessory to my cart' do
        visit '/bike-shop'

        find(".add_accessory_#{@accessories.first.id}").click

        expect(page).to have_content("You now have 1 #{@accessories.first.title} in your cart.")
        expect(page).to have_content("Cart: 1")
      end
    end

    context 'When I click "Add to Cart"' do
      scenario "The message correctly increments for multiple accessories" do
        visit accessories_path

        find(".add_accessory_#{@accessories.first.id}").click

        expect(page).to have_content("You now have 1 #{@accessories.first.title} in your cart.")

        visit accessories_path

        find(".add_accessory_#{@accessories.first.id}").click

        expect(page).to have_content("You now have 2 #{@accessories.first.title}s in your cart.")
        expect(page).to have_content("Cart: 2")
      end
    end
  end

  describe 'When I visit "/bike-shop"' do
    context 'When I click "Add to Cart"' do
      scenario "The total number of accessories in the cart increments" do
        @accessories = create_list(:accessory, 1)
        visit accessories_path

        expect(page).to have_content("Cart: 0")

        click_button "Add to Cart"

        expect(page).to have_content("Cart: 1")
      end
    end
  end
end
