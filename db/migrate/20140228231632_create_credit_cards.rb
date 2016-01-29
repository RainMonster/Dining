class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.references :user, index: true
      t.string :token
      t.timestamps
    end
  end
end