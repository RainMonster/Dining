class AddDetailsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :email, :string
    add_column :users, :password_digest, :string
    remove_column :users, :provider
    remove_column :users, :uid
    remove_column :users, :name
    remove_column :users, :oauth_token
    remove_column :users, :oauth_expires_at
  end
end
