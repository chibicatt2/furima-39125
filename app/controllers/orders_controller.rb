class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :item_find

  def index
    @order_derivery = OrderDerivery.new
    item_find
    if current_user.id == @item.user_id
      redirect_to root_path
    elsif @item.order.blank?
      item_find
    else
      redirect_to root_path
    end
  end

  def create
    @order_derivery = OrderDerivery.new(order_params)
    if @order_derivery.valid?
      pay_item
      @order_derivery.save
      redirect_to root_path
    else
      item_find
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

  def item_find
    @item = Item.find(params[:item_id])
  end
end
