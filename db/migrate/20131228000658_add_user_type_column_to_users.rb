class AddUserTypeColumnToUsers < ActiveRecord::Migration
  def change
    add_column :users, :user_type, :string, default: "Normal User"
  end
end
