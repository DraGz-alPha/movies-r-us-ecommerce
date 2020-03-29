class ChangeImdbIdColumn < ActiveRecord::Migration[6.0]
  def change
    rename_column :movies, :imdb_id, :imdb_number
  end
end
