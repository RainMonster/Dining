class User < ActiveRecord::Base
  require "net/http"
  require "uri"
  attr_accessor :email_subscriber
  # Associations
  has_many :accounts, :dependent => :destroy
  has_many :events
  has_many :reservations
  has_many :credit_cards

  # Instance Methods
  def has_facebook?
    accounts.where(provider: 'facebook').any?
  end

  def email_subscriber(val = "1")
    if val == "1"
      true
    end
  end

  def subscribe_to_mailing_list
    if self.email
      uri = URI.parse("http://sffoodies.us6.list-manage.com/subscribe/post?u=7af9eaca66c3d4d0de9752003&amp;id=2e2f7045f7")
      response = Net::HTTP.post_form(uri, {"EMAIL" => self.email, "FNAME" => self.first_name, "LNAME" => self.last_name})
    end
  end

  def host?
    self.user_type == "Host"
  end

  def user_is_a_host
    if self.host?
      self
    end
  end

  def has_stored_card?
    self.credit_cards.length > 0
  end
end