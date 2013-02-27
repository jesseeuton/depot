class StoreController < ApplicationController
  def index
    if session[:counter].nil?
      session[:counter] = 1
    else
      if session[:counter] > 10
        session[:counter] = 0
      end 
      session[:counter] += 1
    end
    @counter = session[:counter]
    @products = Product.all
  end
end
