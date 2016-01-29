require 'spec_helper'

describe "events/new" do
  before(:each) do
    assign(:event, stub_model(Event,
      :user => nil
    ).as_new_record)
  end

  it "renders new event form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", events_path, "post" do
      assert_select "input#event_user[name=?]", "event[user]"
    end
  end
end
