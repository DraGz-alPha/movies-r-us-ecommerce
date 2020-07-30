class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :load_cart

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name email address province_id])
  end

  private 
  
  def load_cart
    if current_customer
      movies = session[:cart]
      @cart = Movie.find(movies.keys)
    end
  end
end
