class Admin::DashboardController < Admin::BaseController
  def index
    @orders = Order.all
    @orders_by_status = orders_by_status
  end

 private

   def orders_by_status
    Order.where(status: params[:status])
   end
end
