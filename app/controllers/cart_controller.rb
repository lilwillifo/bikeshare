class CartController < ApplicationController
  include ActionView::Helpers::TextHelper

  def create
    @accessory = Accessory.find(params[:accessory_id])
    @cart = Cart.new(session[:cart])
    @cart.add_accessory(@accessory.id)
    session[:cart] = @cart.contents
    flash[:notice] = "You now have #{pluralize(session[:cart][@accessory.id.to_s], @accessory.title)} in your cart."
    redirect_to cart_path
  end

  def index
  end

  def destroy
    session[:cart].delete(params[:item])
    accessory = Accessory.find(params[:item])
    flash[:notice] = "Successfully removed <a href=\"#{accessory_path(accessory)}\" class=\"remove-link\">#{accessory.title}</a> from your cart.".html_safe
    redirect_to cart_path
  end

  def update
    accessory = Accessory.find(params[:accessory_id])
    @cart.decrease_accessory(accessory.id)
    flash[:notice] = "Successfully reduced quantity of #{accessory.title} in your cart."
    redirect_to cart_path
  end
end
