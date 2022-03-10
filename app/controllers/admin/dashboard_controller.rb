class Admin::DashboardController < ApplicationController
 def index
  @product_count = Product.all.count()
  @category_count = Category.all.count()
end

end
