class CreateMovieOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_orders do |t|
      t.integer :quantity
      t.decimal :movie_price
      t.references :movie, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
