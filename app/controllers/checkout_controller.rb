class CheckoutController < ApplicationController
  def create
    if current_customer
      movies = Movie.find(session[:cart].keys)

      if movies.empty?
        redirect_to root_path
        nil
      end

      line_items = []
      purchase_price = 0

      movies.each do |movie|
        purchase_price += (movie.price * 100).to_i * session[:cart].fetch(movie.id.to_s)
        line_items << {
          name: movie.title,
          description: movie.description,
          amount: (movie.price * 100).to_i,
          currency: 'cad',
          quantity: session[:cart].fetch(movie.id.to_s),
          images: [movie.poster]
        }
      end

      if current_customer.province.pst_rate > 0
        line_items << {
          name: 'PST',
          description: "Provincial Sales Tax @ #{current_customer.province.pst_rate * 100}%",
          amount: (purchase_price * current_customer.province.pst_rate).to_i,
          currency: 'cad',
          quantity: 1
        }
      end
      if current_customer.province.gst_rate > 0
        line_items << {
          name: 'GST',
          description: "Goods and Services Tax @ #{current_customer.province.gst_rate * 100}%",
          amount: (purchase_price * current_customer.province.gst_rate).to_i,
          currency: 'cad',
          quantity: 1
        }
      end
      if current_customer.province.hst_rate > 0
        line_items << {
          name: 'HST',
          description: "Harmonized Sales Tax @ #{current_customer.province.hst_rate * 100}%",
          amount: (purchase_price * current_customer.province.hst_rate).to_i,
          currency: 'cad',
          quantity: 1
        }
      end

      @session = Stripe::Checkout::Session.create(
        customer_email: current_customer.email,
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
        line_items: line_items,
        success_url: checkout_success_url,
        cancel_url: checkout_cancel_url
      )

      respond_to do |format|
        format.js # render app/views/checkout/create.js.erb
      end
    else
      redirect_to new_customer_session_path
      nil
    end
  end
end
