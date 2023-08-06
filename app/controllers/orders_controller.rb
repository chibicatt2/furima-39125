class OrdersController < ApplicationController
  def index
    @order_derivery = OrderDerivery.new
    @item = Item.find(params[:item_id])
  end

  def create
    @order_derivery = OrderDerivery.new(order_params)
    if @order_derivery.valid?
      @order_derivery.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_params
    params.require(:order_derivery).permit(:postcode, :area_id, :municipality, :address, :building_name, :phone_number, :order_id).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end
