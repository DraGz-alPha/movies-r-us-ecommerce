ActiveAdmin.register Movie do
  permit_params :imdb_number, :title, :language, :description, :poster, :release_date, :length, :price, :sale_price
end
