class RemoveProvinceIdFromCustomer < ActiveRecord::Migration[6.0]
  def change
    remove_column :customers, :provinceId
  end
end
