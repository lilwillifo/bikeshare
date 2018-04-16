class Admin::OrdersController < Admin::BaseController

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.update(status: params[:status])
    if order.save
      flash[:success] = "Updated status to #{params[:status]}."
    else
      flash[:error] = "Unable to update order status."
    end
      redirect_to admin_dashboard_path(status: params[:status])
  end
end
