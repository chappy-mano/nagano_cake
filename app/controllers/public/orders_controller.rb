class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
    @customer = current_customer
    @addresses = Address.where(customer_id: current_customer.id)
  end

  def confirm
    @order = Order.new(order_params)
    @addresses = Address.where(customer_id: current_customer.id)
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @order.status = "入金待ち"

    if params[:order][:address_status] == "0"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_status] == "1"
      address = Address.find(params[:address][:address_id])
      @order.address = address.address
      @order.postal_code = address.postal_code
      @order.name = address.name
    end

    @subtotal = 0
    @cart_items.each do |cart_item|
      @subtotal += (cart_item.amount)*(cart_item.item.price*1.1)
    end
    @order.total_payment = @subtotal + @order.shipping_cost
  end

  def create
    address_status = order_params.delete(:address_status) #order内のaddress_statusを削除しつつ、変数を定義
    @order = Order.new(order_params)

    if address_status == "0"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.last_name + current_customer.first_name
    elsif address_status == "1"
      address = Address.find(address_status)
      @order.address = address.address
      @order.postal_code = address.postal_code
      @order.name = address.name
    end

    # @order.customer_id = current_customer.id
    puts @order.inspect
    @order.save!
    redirect_to thanks_orders_path
  end

  def thanks
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
    
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
      :status,
      :address_status,
      :address_id
      )
  end
end