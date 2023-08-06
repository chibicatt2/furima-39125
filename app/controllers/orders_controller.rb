class OrdersController < ApplicationController
  def index
    @order_derivery = OrderDerivery.new
  end
end
