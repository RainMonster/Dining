require 'spec_helper'

describe CreditCardsController do
  let(:user) { create(:user) }
  let(:card) { Hashie::Mash.new( { token: 'a_token', last_4: 'last_4', card_type: 'visa'} )}
  let(:params) { {id: 1} }
  
  before do
    current_user(user)
  end

  context 'credit_card#create' do
    it "changes credit card count by one" do
      Braintree::Customer.should_receive(:create).and_return(
        Hashie::Mash.new( 
          {
            id: "id", 
            token: "token", 
            success?: true, 
            customer: Hashie::Mash.new( 
              { 
                credit_cards: [card] 
              }
            )
          } 
        ))
      expect{
        post :create
      }.to change(CreditCard, :count).by(1)
    end

  end

  context 'credit_card#destroy' do
    it "removes credit card" do
      card = create(:credit_card)
      p '* ' * 20
      p "~~~~~~~~~~~~~~~~~~~ card: #{card}"
      p params[:id]
      expect{
        post :destroy
      }.to change(CreditCard,:count).by(-1)
    end
  end  

end

  # expect{
  #   post :create, contact: Factory.attributes_for(:contact)
  # }.to change(Contact,:count).by(1)

  # context "bridges#create" do
  #   describe "invalid attributes" do
  #     let(:user) { create(:user) }
  #     before do
  #       current_user(user)
  #     end
  #     it "does not save" do
  #       expect { post :create, user_id: user.id, bridge: { "ip" => nil, "device_id" => nil, "user_id" => 1} }.to_not change(Bridge,:count)
  #     end

  #     it "redirects to new_user_bridge_path" do
  #       post :create, user_id: user.id, bridge: { "ip" => nil, "device_id" => nil, "user_id" => 1}
  #       expect { response }.to redirect_to new_user_bridge_path(user)
  #     end
  #   end


  ######### Code Graveyard for CC test
      # post :create
      # result.should redirect_to { post :create, user: user }.to change(CreditCard,:count)
      # This one works-ish: stub_request(:any, "www.braintree.com").to_return({id: "id", token: "token"})
      # response.should redirect_to edit_user_path current_user(user)
      # Proccess::Status.stub(:success?).and_return(true)
      # result.stub(:success?).and_return(true)
      # Braintree::Customer.stub(:create).and_return({id: "id", token: "token"})


      # Braintree::Customer.stub_any_instance(:create).and_return(Hashie::Mash.new({id: "id", token: "token"}))
      # braintree_mock.should_receive(:create).and_return(Hashie::Mash.new({id: "id", token: "token"}))
      # double = Braintree::Customer
      # Process::Status.should_receive(:success?).and_return(true)
      # (:response).stub().and_return({id: "id", token: "token"})
      # stub_request(:any, "www.braintree.com").to_return( Hashie::Mash.new({id: "id", token: "token"}) )
