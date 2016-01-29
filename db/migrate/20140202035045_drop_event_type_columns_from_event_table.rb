class DropEventTypeColumnsFromEventTable < ActiveRecord::Migration
  def change
    remove_column :events, :type
    remove_column :events, :refundable
    remove_column :events, :refund_type
    remove_column :events, :cancellation_fee
    remove_column :events, :nommery_cancellation_fee
  end
end
