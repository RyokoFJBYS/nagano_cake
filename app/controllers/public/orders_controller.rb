class Public::OrdersController < ApplicationController

  def new
    @order = Order.new
  end

  def comfirm
    @cart_items = CartItem.all
    @order = Order.new(order_params)
    @order.shipping_cost = 800
    if params[:order][:address_select] == "a"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_select] == "b"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
    end
  end

  def create
    @order = Order.new(order_params)
    @order.status = 0
    @order.customer_id = current_customer.id
    @order.save
    @cart_items = CartItem.all
    @cart_items.each do |cart_item|
      order_detail = OrderDetail.new
      order_detail.amount = cart_item.amount
      order_detail.item_id = cart_item.item_id
      order_detail.order_id = @order.id
      order_detail.making = 0
      order_detail.price = cart_item.item.price
      order_detail.save
     end
    CartItem.destroy_all
    redirect_to complete_orders_path
  end

  def complete
  end

  def index
    @orders = Order.all
    @order_details = OrderDetail.all
  end

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.all
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :shipping_cost, :total_payment, :payment_method)
  end

end
