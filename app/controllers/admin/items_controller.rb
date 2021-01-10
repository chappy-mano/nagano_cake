class Admin::ItemsController < ApplicationController
  before_action :authenticate_admin!, except: :index

  def index
    @items = Item.all
    # @genres = Genre.all
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def create
    @item = Item.new(item_params)
    @genres = Genre.all
    @item.save
    redirect_to admin_items_path
  end

  def show
    @item = Item.find(params[:id])
    # @tax_price = @item.price * 1.1
  end

  def edit
    @item = Item.find(params[:id])
    @genres = Genre.all
  end

  def update
    @item = Item.find(params[:id])
    @item.update(item_params)
    redirect_to admin_item_path(@item.id)
  end

  private
  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :is_active, :genre_id)
  end
end