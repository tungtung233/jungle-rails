# test that users can navigate from the home page to the product detail page by clicking on a product.
require 'rails_helper'

RSpec.feature "Visitor can click on a product on the homepage to see more details", type: :feature, js:true do

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

  scenario 'They can click on a product' do
    visit root_path

    click_on 'Details', match: :first

    expect(page).to have_css('article.product-detail')
    
    find('.main-img').visible?

    puts page.html
  
    save_screenshot
  end

end
