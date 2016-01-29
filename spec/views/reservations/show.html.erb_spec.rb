require 'spec_helper'

describe "reservations/show" do
  before(:each) do
    @reservation = assign(:reservation, stub_model(Reservation,
      :user => nil,
      :event => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
