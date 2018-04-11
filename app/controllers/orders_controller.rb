class OrdersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  
  def create
    order = Order.create!(user: current_user)
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
end