class AddDefaultAmountValueToEventTable < ActiveRecord::Migration
  def change
    change_column :events, :amount, :decimal, precision: 9, scale: 2, default: 1
  end
end
