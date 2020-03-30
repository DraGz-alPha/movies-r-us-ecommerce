class AddGenreNumberToGenre < ActiveRecord::Migration[6.0]
  def change
    add_column :genres, :genre_number, :int
  end
end
