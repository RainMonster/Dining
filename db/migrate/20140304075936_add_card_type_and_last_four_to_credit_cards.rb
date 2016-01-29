class AddCardTypeAndLastFourToCreditCards < ActiveRecord::Migration
  def change
    add_column :credit_cards, :card_type, :string
    add_column :credit_cards, :last_4, :string
  end
end
