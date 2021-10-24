class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.save
    redirect_to cart_items_path
  end
  
  private

  def post_image_params
    params.require(:cart_item).permit(:item_id, :customer_, :amount)
  end
  
end
