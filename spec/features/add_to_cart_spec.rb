# test that users can click the 'Add to Cart' button for a product on the home page and in doing so their cart increases by one
require 'rails_helper'

RSpec.feature "Add items to cart", type: :feature, js:true do
  
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end


  scenario 'They can click on a product to get to product#show page' do
    visit root_path

    expect(page).to have_content('My Cart (0)')

    save_screenshot

    click_on 'Add', match: :first
    
    expect(page).to have_content('My Cart (1)')

    puts page.html
  
    save_screenshot
  end

end
