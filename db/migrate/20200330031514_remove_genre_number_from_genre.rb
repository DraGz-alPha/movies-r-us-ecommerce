class RemoveGenreNumberFromGenre < ActiveRecord::Migration[6.0]
  def change
    remove_column :genres, :genre_number
  end
end
