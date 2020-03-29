ActiveAdmin.register MovieOrder do
  permit_params :quantity, :movie_price, :movie_id, :order_id
end
