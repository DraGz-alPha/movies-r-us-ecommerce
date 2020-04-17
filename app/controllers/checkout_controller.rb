class CheckoutController < ApplicationController
  def create
    movies = Movie.find(session[:cart].keys)

    if movies.empty?
      redirect_to root_path
      nil
    end

    line_movies = []

    movies.each do |movie|
      line_movies << {
        name: movie.title,
        description: movie.description,
        amount: (movie.price * 100).to_i,
        currency: 'cad',
        quantity: session[:cart].fetch(movie.id.to_s),
        images: [movie.poster]
      }
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      # line_items: [
      #   {
      #     name: movie.title,
      #     description: movie.description,
      #     amount: (movie.price * 100).to_i,
      #     currency: 'cad',
      #     quantity: 1
      #   }
      # ],
      line_items: line_movies,
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end
end
