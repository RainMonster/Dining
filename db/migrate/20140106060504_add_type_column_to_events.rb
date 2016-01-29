class AddTypeColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :type, :string, default: "Event"
    add_column :events, :rsvp_fee, :boolean, default: true
    add_column :events, :refundable, :boolean, default: true
    add_column :events, :refund_type, :string, default: "rsvp_fee"
    add_column :events, :cancellation_fee, :decimal, precision: 9, scale: 2, default: 0
  end
end
