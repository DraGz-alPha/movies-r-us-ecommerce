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
        purchase_price += movie.price * session[:cart].fetch(movie.id.to_s)
        line_items << {
          name:        movie.title,
          description: movie.description,
          amount:      movie.price,
          currency:    "cad",
          quantity:    session[:cart].fetch(movie.id.to_s),
          images:      [movie.poster]
        }
      end

      if current_customer.province.pst_rate > 0
        line_items << {
          name:        "PST",
          description: "Provincial Sales Tax @ #{current_customer.province.pst_rate * 100}%",
          amount:      (purchase_price * current_customer.province.pst_rate).to_i,
          currency:    "cad",
          quantity:    1
        }
      end
      if current_customer.province.gst_rate > 0
        line_items << {
          name:        "GST",
          description: "Goods and Services Tax @ #{current_customer.province.gst_rate * 100}%",
          amount:      (purchase_price * current_customer.province.gst_rate).to_i,
          currency:    "cad",
          quantity:    1
        }
      end
      if current_customer.province.hst_rate > 0
        line_items << {
          name:        "HST",
          description: "Harmonized Sales Tax @ #{current_customer.province.hst_rate * 100}%",
          amount:      (purchase_price * current_customer.province.hst_rate).to_i,
          currency:    "cad",
          quantity:    1
        }
      end

      @session = Stripe::Checkout::Session.create(
        customer_email:       current_customer.email,
        payment_method_types: ["card"],
        # line_items: [
        #   {
        #     name: movie.title,
        #     description: movie.description,
        #     amount: (movie.price * 100).to_i,
        #     currency: 'cad',
        #     quantity: 1
        #   }
        # ],
        line_items:           line_items,
        success_url:          checkout_success_url + "?session_id={CHECKOUT_SESSION_ID}",
        cancel_url:           checkout_cancel_url
      )

      respond_to do |format|
        format.js # render app/views/checkout/create.js.erb
      end
    else
      redirect_to new_customer_session_path
      nil
    end
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @payment_intent = Stripe::PaymentIntent.retrieve(@session.payment_intent)

    session_details = JSON.parse(@session.to_s)
    payment_details = JSON.parse(@payment_intent.to_s)

    subtotal = 0
    tax = 0

    session_details["display_items"].each do |item|
      if item["custom"]["name"] == "PST" || item["custom"]["name"] == "GST" || item["custom"]["name"] == "HST"
        tax += item["amount"]
      else
        subtotal += item["amount"] * item["quantity"]
      end
    end

    order = Order.create(reference_number: payment_details["id"],
                         customer:         current_customer,
                         pst_rate:         current_customer.province.pst_rate,
                         gst_rate:         current_customer.province.gst_rate,
                         hst_rate:         current_customer.province.hst_rate,
                         subtotal:         subtotal,
                         total:            subtotal + tax,
                         address:          current_customer.address,
                         order_status:     payment_details["status"] == "succeeded" ? "Paid" : "Failed")

    session_details["display_items"].each do |movie|
      current_movie = Movie.where(title: movie["custom"]["name"]).first
      movie_quantity = movie["quantity"]
      MovieOrder.create(movie:       current_movie,
                        order:       order,
                        quantity:    movie["quantity"],
                        movie_price: movie["amount"])
    end
  end
end
