class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @tax_price = @item.price * 1.1
  end

  def show
    @item = Item.find(params[:id])
    @tax_price = @item.price * 1.1
  end

end
