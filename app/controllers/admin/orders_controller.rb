class Admin::OrdersController < ApplicationController

  def index
    if params[:sort] == "0"
      @orders = Order.all
    elsif params[:sort] == "1"
      customer = Customer.find(params[:customer_id])
      @orders = customer.orders
    end

  end

  def show
    @order = Order.find(params[:id])

    @subtotal = 0
    @order.order_details.each do |order_detail|
      @subtotal += (order_detail.amount)*(order_detail.item.price*1.1)
    end
  end

  def update
  end

  private

end
