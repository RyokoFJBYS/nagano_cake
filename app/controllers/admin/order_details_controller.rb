class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    redirect_to admin_order(order.id)
  end

  def user_params
    params.require(:order_detail).permit(:making)
  end

end
