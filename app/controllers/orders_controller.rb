class OrdersController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def create
    order = Order.create!(user: current_user, status: 'Ordered')
    total = 0
    @cart.items.each do |item|
      OrderAccessory.create!(
        order: order,
        accessory: item[:accessory],
        quantity: item[:quantity]
      )

      total += item[:accessory].price * item[:quantity]
    end

    flash[:notice] = "Successfully submitted your order totaling #{number_to_currency(total)}"
    redirect_to dashboard_path
  end

  def show
    @order = Order.find_by_id(params[:id])
    return render_404 if @order.nil?
    return render_404 if @order.user != current_user
  end

  private
  def render_404
    render file: "#{Rails.root}/public/404.html", status: 404
  end
end
