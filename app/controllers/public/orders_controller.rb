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

    if params[:payment_method] == "0"
      @order.payment_method = "クレジットカード"
    elsif params[:payment_method] == "1"
      @order.payment_method = "銀行振込"
    end

    if params[:order][:address_status] == "0"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_status] == "1"
      address = Address.find(params[:order][:address_id])
      @order.address = address.address
      @order.postal_code = address.postal_code
      @order.name = address.name
    # else @address_status == 2
    end

    @subtotal = 0
    @cart_items.each do |cart_item|
      @subtotal += (cart_item.amount)*(cart_item.item.price*1.1)
    end
    @order.total_payment = @subtotal + @order.shipping_cost
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
    params.require(:order).permit(
      :customer_id,
      :postal_code,
      :address,
      :name,
      :shipping_cost,
      :total_payment,
      :payment_method,
      :address_status
      )
    params.permit(
      :address_status,
      :address_id
      )
  end
end