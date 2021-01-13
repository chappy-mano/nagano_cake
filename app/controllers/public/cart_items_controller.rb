class Public::CartItemsController < ApplicationController
  # before_action :authenticate_user!

  def index
    @cart_items = CartItem.all
    # @subtotal_price = (cart_item.amount)*(cart_item.item.price*1.1).floor
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.customer_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_items_path
  end

  def destroy_all
    # ログインしているユーザーのみのカート商品を消す
    # cart_items = CartItem.all
    # cart_items.destroy_all
    # redirect_to cart_items_path

    customer = Customer.find(params[:id])
    cart_items = CartItem.customer.all
    cart_items.destroy_all
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  private
  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :customer_id)
  end
end
