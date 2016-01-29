class AddTransactionNumberAndStatusToReservations < ActiveRecord::Migration
  def change
    add_column :reservations, :status, :string
    add_column :reservations, :transaction_number, :string
  end
end
