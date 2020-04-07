ActiveAdmin.register Movie do
  permit_params :imdb_number, :title, :language, :description, :poster, :release_date, 
                :length, :price, :sale_price, movie_genres_attributes: [:id, :movie_id, :genre_id, :_destroy],
                movie_producers_attributes: [:id, :movie_id, :producer_id, :_destroy]

  index do |movie|
    selectable_column
    column :imdb_number
    column :title
    column :language
    column :description
    column :poster
    column :release_date
    column :length
    column :price
    column :sale_price
    column :genres do |movie|
      movie.genres.map { |gnr| gnr.name }.join(", ").html_safe
    end
    column :producers do |movie|
      movie.producers.map { |pdr| pdr.name }.join(", ").html_safe
    end
    actions
  end

  show do |movie|
    attributes_table do
      row :imdb_number
      row :title
      row :language
      row :description
      row :poster
      row :release_date
      row :length
      row :price
      row :sale_price
      row :genres do |movie|
        movie.genres.map { |gnr| gnr.name }.join(", ").html_safe
      end
      row :producers do |movie|
        movie.producers.map { |pdr| pdr.name }.join(", ").html_safe
      end
    end
  end
  
  form do |f|
    f.semantic_errors *f.object.errors.keys

    f.inputs "Movie" do
      f.input :imdb_number
      f.input :title
      f.input :language
      f.input :description
      f.input :poster
      f.input :release_date
      f.input :length
      f.input :price
      f.input :sale_price
      f.has_many :movie_genres, allow_destroy: true do |n_f|
        n_f.input :genre
      end
      f.has_many :movie_producers, allow_destroy: true do |n_f|
        n_f.input :producer
      end
    end

    f.actions
  end
end
