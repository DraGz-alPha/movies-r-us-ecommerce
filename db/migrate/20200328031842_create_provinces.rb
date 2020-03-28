class CreateProvinces < ActiveRecord::Migration[6.0]
  def change
    create_table :provinces do |t|
      t.string :name
      t.decimal :pst_rate
      t.decimal :gst_rate

      t.timestamps
    end
  end
end
