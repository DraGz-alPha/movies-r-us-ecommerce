class OrdersController < ApplicationController
  def index
    if current_customer
      @orders = Order.all
    else
      redirect_to root_path
    end
  end

  def show
    if current_customer
      @order = Order.includes(:movie_orders).find(params[:id])
    else
      redirect_to root_path
    end
  end
end
