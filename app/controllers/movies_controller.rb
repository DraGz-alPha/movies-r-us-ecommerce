class MoviesController < ApplicationController
  before_action :initialize_session
  before_action :load_cart

  def index
    @movies = Movie.all.page(params[:page])
  end

  def show
    @movie = Movie.includes(:genres).find(params[:id])
  end

  def add_to_cart
    id = params[:id].to_i
    session[:cart][id] = 1 unless session[:cart].include?(id)
    redirect_to root_path
  end
  # No associated view. Redirects back to index.

  def remove_from_cart
    id = params[:id]
    session[:cart].delete(id)
    redirect_to root_path
  end
  # No associated view. Redirects back to index.

  def increase_quantity
    id = params[:id]
    current_quantity = session[:cart].fetch(id)
    updated_movie = { id => current_quantity += 1 }
    session[:cart].merge!(updated_movie)
    redirect_to root_path
  end
  # No associated view. Redirects back to index.

  def decrease_quantity
    id = params[:id]
    current_quantity = session[:cart].fetch(id)
    if current_quantity > 1 then
      updated_movie = { id => current_quantity -= 1 }
      session[:cart].merge!(updated_movie)
    end
    redirect_to root_path
  end
  # No associated view. Redirects back to index.

  private

  def initialize_session
    session[:cart] ||= {} # Empty cart is an empty hash.
  end

  def load_cart
    movies = session[:cart]
    @cart = Movie.find(movies.keys)
  end
end
