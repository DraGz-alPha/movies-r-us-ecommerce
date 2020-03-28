class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.string :imdb_id
      t.string :title
      t.string :language
      t.text :description
      t.string :poster
      t.datetime :release_date
      t.decimal :length
      t.decimal :price
      t.decimal :sale_price

      t.timestamps
    end
  end
end
