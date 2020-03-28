class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string :reference_number
      t.decimal :pst_rate
      t.decimal :gst_rate
      t.decimal :subtotal
      t.decimal :total
      t.string :address
      t.references :customer, null: false, foreign_key: true

      t.timestamps
    end
  end
end
