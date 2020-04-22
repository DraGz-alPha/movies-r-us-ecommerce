class AddHstRateToOrders < ActiveRecord::Migration[6.0]
  def change
    add_column :orders, :hst_rate, :decimal
  end
end
