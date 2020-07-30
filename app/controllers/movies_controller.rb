class MoviesController < ApplicationController
  before_action :initialize_session

  def index
    @movies = Movie.all.page(params[:page])
    @genres = Genre.all
  end

  def show
    @movie = Movie.includes(:genres).find(params[:id])
  end

  def search
    genre_id = params[:genre_id]
    search_title = params[:title]
    if genre_id.blank?
      @movies = Movie.where("title LIKE ?", "%#{params[:title].downcase}%").page(params[:page])
    else
      @movies = Movie.joins(:genres).where("title LIKE ? AND genres.id = ?", "%#{params[:title]}%", params[:genre_id]).page(params[:page])
    end
    @genres = Genre.all
  end

  def cart
  end

  def add_to_cart
    if current_customer
      id = params[:id].to_i
      session[:cart][id] = 1 unless session[:cart].include?(id)
      redirect_to root_path
    else
      redirect_to new_customer_session_path
    end
  end
  # No associated view. Redirects back to index.

  def remove_from_cart
    id = params[:id]
    session[:cart].delete(id)
    redirect_to cart_path
  end
  # No associated view. Redirects back to index.

  def increase_quantity
    id = params[:id]
    current_quantity = session[:cart].fetch(id)
    updated_movie = { id => current_quantity += 1 }
    session[:cart].merge!(updated_movie)
    redirect_to cart_path
  end
  # No associated view. Redirects back to index.

  def decrease_quantity
    id = params[:id]
    current_quantity = session[:cart].fetch(id)
    if current_quantity > 1
      updated_movie = { id => current_quantity -= 1 }
      session[:cart].merge!(updated_movie)
    end
    redirect_to cart_path
  end
  # No associated view. Redirects back to index.

  private

  def initialize_session
    session[:cart] ||= {} # Empty cart is an empty hash.
  end
end
