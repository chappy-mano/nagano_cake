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

    @order_detail = @order.order_details.new
    @order_detail.making_status = "着手不可"
  end


  def create
    address_status = order_params.delete(:address_status) #order内のaddress_statusを削除しつつ、変数を定義
    @order = Order.new(order_params)

    # if address_status == "0"
    #   @order.address = current_customer.address
    #   @order.postal_code = current_customer.postal_code
    #   @order.name = current_customer.last_name + current_customer.first_name
    # elsif address_status == "1"
    #   address = Address.find(address_status)
    #   @order.address = address.address
    #   @order.postal_code = address.postal_code
    #   @order.name = address.name
    # end

    if @order.save
      # current_customer.cart_items.each do |cart_item|
      #   @order_detail = OrderDetail.new
      #   @order_detail.order_id = @order.id
      #   @order_detail.item_id = cart_item.item_id
      #   @order_detail.amount = cart_item.amount
      #   @order_detail.price = cart_item.item.price
      #   byebug
      #   if @order_detail.save
      #   else
      #     render :new
      #   end
      # end
      redirect_to thanks_orders_path
    else
      @customer = current_customer
      @addresses = Address.where(customer_id: current_customer.id)
      render :new
    end
  end

  def thanks
  end

  def index
    @orders = Order.where(customer_id: current_customer.id)
  end

  def show
    @order =Order.find(params[:id])

    @subtotal = 0
    @order.order_details.each do |order_detail|
      @subtotal += (order_detail.amount)*(order_detail.item.price*1.1)
    end

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
      :address_id,
      order_details_attributes: [
        :id,
        :order_id,
        :item_id,
        :amount,
        :price,
        :making_status
        ]
      )
  end


end