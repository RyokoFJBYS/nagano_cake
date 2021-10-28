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
    @order.customer_id = current_customer.id
    @order.save
    CartItem.destroy_all
    redirect_to complete_orders_path
  end

  def complete
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :name, :postal_code, :address, :shipping_cost, :total_payment, :payment_method, :status)
  end

end
