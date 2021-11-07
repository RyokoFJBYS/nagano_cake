class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    redirect_to request.referer
  end

  def order_detail_params
    params.require(:order_detail).permit(:making, :item_id, :order_id)
  end

end
