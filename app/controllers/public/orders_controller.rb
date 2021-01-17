class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = Address.where(customer_id: current_customer.id)
    # @address = Address.new
  end

  def confirm
    @order = Order.new(order_params)
    @addresses = Address.where(customer_id: current_customer.id)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800


    if params[:order][:address_status] == "0"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_status] == "1"
      address = Address.find(params[:id])
      @order.address = address.address
      @order.postal_code = address.postal_code
      @order.name = address.name
    # else @address_status == 2
    end
    # render :new if @order.invalid?
  end

  def create
    @order = Order.new(order_params)
    @order.save!
    redirect_to thanks_orders_path
  end

  def thanks
  end

  def index
  end

  def show
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :payment_method, :status, :address_status, :id)
  end
end
