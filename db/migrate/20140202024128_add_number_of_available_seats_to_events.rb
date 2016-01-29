class AddNumberOfAvailableSeatsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :number_of_available_seats, :integer
  end
end
