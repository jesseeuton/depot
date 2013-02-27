class ApplicationController < ActionController::Base
  protect_from_forgery

  #user added.  private means that it can be access by all controllers, but not as an action method.
  private
  def current_cart
    Cart.find(session[:cart_id])

  rescue ActiveRecord::RecordNotFound
    cart = Cart.create
    session[:cart_id] = cart.id
    return cart
  end
end
