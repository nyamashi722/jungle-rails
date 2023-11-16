class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV['BASIC_AUTH_USERNAME'], password: ENV['BASIC_AUTH_PASSWORD'], only: :show
  def show
    @num_of_products = Product.count
    @num_of_categories = Category.count
  end
end
