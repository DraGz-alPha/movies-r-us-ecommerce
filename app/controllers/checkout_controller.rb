class CheckoutController < ApplicationController
  def create
    movie = Movie.find(params[:id])

    if movie.nil?
      redirect_to root_path
      nil
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ['card'],
      line_items: [
        {
          name: movie.title,
          description: movie.description,
          amount: (movie.price * 100).to_i,
          currency: 'cad',
          quantity: 1
        }
      ],
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )

    respond_to do |format|
      format.js # render app/views/checkout/create.js.erb
    end
  end
end
