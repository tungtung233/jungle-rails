class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with :name => ENV['ADMIN_USERNAME'], :password => ENV['ADMIN_PASSWORD']

  def show
    @product_count = Product.all.count
    @category_count = Category.all.count

    puts @product_count
    puts @category_count
  end
end
