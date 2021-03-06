class Admin::OrderDetailsController < ApplicationController

  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order_detail.update(order_detail_params)
    if @order_detail.making == "production"
      @order_detail.order.update(status: "production")
    end
    @order = @order_detail.order
    sum = 0
    @order.order_details.each do |order_detail|
      if order_detail.making == "completion"
        sum += 1
      end
    end
    if @order.order_details.count == sum
      @order_detail.order.update(status: "ready")
    end
    redirect_to request.referer
  end

  def order_detail_params
    params.require(:order_detail).permit(:making, :item_id, :order_id)
  end

end
