class ChangeRefundableDefaultForEventTable < ActiveRecord::Migration
  def change
    change_column_default(:events, :refundable, false)
    change_column_default(:events, :refund_type, "none")
  end
end
