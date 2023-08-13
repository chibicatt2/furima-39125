class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @order_derivery = OrderDerivery.new
    @item = Item.find(params[:item_id])
    return if @item.order.blank?
      redirect_to root_path
  
  end

  def create
    @order_derivery = OrderDerivery.new(order_params)
    if @order_derivery.valid?
      pay_item
      @order_derivery.save
      redirect_to root_path
    else
      @item = Item.find(params[:item_id])
      render :index
    end
  end

  private

  def order_params
    params.require(:order_derivery).permit(:postcode, :area_id, :municipality, :address, :building_name, :phone_number).merge(
      user_id: current_user.id, item_id: params[:item_id], token: params[:token]
    )
  end

  def pay_item
    @item = Item.find(params[:item_id])
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end
end
