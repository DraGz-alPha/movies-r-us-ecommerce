class ChangePricesToCents < ActiveRecord::Migration[6.0]
  def change
    change_column :orders, :subtotal, :integer
    change_column :orders, :total, :integer

    change_column :movie_orders, :movie_price, :integer

    change_column :movies, :price, :integer
    change_column :movies, :sale_price, :integer
  end
end
