class RenameMaikingStatusColumnToOrderDetails < ActiveRecord::Migration[5.2]
  def change
    rename_column :order_details, :maiking_status, :making_status
  end
end
