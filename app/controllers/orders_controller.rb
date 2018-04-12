class OrdersController < ApplicationController
  include ActionView::Helpers::NumberHelper

  def create
    order = Order.create!(user: current_user, status: 'ordered')
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
    @order = Order.find(params[:id])
    if @order.user != current_user
      flash[:notice] = "Order ##{params[:id]} not found."
      redirect_to dashboard_path
    end
  end
end