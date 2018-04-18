require 'rails_helper'

describe 'As a visitor' do
  describe 'I add items to my cart' do
    describe 'I then create an account' do
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

        click_link 'Login'

        expect(current_path).to eq('/login')

        click_link 'Create Account'

        expect(current_path).to eq(new_user_path)
        fill_in 'Username', with: 'TylerRox'
        fill_in 'Password', with: 'SeCrEtZ'
        click_on 'Submit'

        visit cart_path
      end

      describe 'When I visit /cart' do
        scenario 'I can see a thumbnail for each accessory as well as title and price' do
          expect(page).to have_content(@accessory.title)
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
  end
end
