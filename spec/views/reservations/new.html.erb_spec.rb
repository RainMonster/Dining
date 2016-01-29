require 'spec_helper'

describe "reservations/new" do
  before(:each) do
    assign(:reservation, stub_model(Reservation,
      :user => nil,
      :event => nil
    ).as_new_record)
  end

  it "renders new reservation form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", reservations_path, "post" do
      assert_select "input#reservation_user[name=?]", "reservation[user]"
      assert_select "input#reservation_event[name=?]", "reservation[event]"
    end
  end
end
