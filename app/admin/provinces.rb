ActiveAdmin.register Province do
  permit_params :name, :pst_rate, :gst_rate, :hst_rate, :image

  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs          # builds an input field for every attribute
    f.inputs do       
      f.input :image, as: :file
    end
    f.actions 
  end
end
