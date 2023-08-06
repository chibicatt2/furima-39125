class OrdersController < ApplicationController
  def index
    @order_derivery = OrderDerivery.new
    @item = Item.find(params[:item_id])
  end
end
