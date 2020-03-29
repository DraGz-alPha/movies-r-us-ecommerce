ActiveAdmin.register Order do
  permit_params :reference_number, :pst_rate, :gst_rate, :subtotal, :total, :address, :customer_id
end
