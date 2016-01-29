class CreditCard < ActiveRecord::Base
  belongs_to :user

  def to_s
    self.card_type + ": **** **** **** " + self.last_4
  end
end
