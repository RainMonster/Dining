FactoryGirl.define do

  factory :user do
    id 1
    first_name 'first'
    last_name 'last'
    email "TeSt@teSt.cOm"
  end

  trait :with_credit_card do
    after :create do |user|
      FactoryGirl.create_list :credit_card, 1, user: user
    end
  end

  factory :credit_card do
    id 1
    token 'a_token'
    last_4 'last_4'
    card_type 'visa'
  end

  
end