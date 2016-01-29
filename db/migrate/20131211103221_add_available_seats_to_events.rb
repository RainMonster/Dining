class AddAvailableSeatsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :available_seats, :boolean, default: true
  end
end
