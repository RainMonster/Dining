class AddDiningCancellationFeeColumnToEventsTable < ActiveRecord::Migration
  def change
    add_column :events, :nommery_cancellation_fee, :decimal, precision: 9, scale: 2, default: 0
  end
end