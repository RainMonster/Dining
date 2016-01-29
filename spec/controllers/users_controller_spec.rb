require 'spec_helper'

describe UsersController do

  context "users#new" do
    let(:user) { create(:user)}
    it 'creates new user' do
      get :new
      expect(assigns(:user)).to_not be_nil
    end
  end


  # describe "GET 'new'" do
  #   it "returns http success" do
  #     get 'new'
  #     response.should be_success
  #   end
  # end

end
