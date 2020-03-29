ActiveAdmin.register Customer do
  permit_params :name, :email, :address, :province_id
end
