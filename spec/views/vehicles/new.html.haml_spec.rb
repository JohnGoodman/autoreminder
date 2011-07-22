require 'spec_helper'

describe "vehicles/new.html.haml" do
  before(:each) do
    assign(:vehicle, stub_model(Vehicle,
      :year => 1,
      :make => "MyString",
      :model => "MyString",
      :email => "MyString",
      :unsubscribe => false
    ).as_new_record)
  end

  it "renders new vehicle form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => vehicles_path, :method => "post" do
      assert_select "input#vehicle_year", :name => "vehicle[year]"
      assert_select "input#vehicle_make", :name => "vehicle[make]"
      assert_select "input#vehicle_model", :name => "vehicle[model]"
      assert_select "input#vehicle_email", :name => "vehicle[email]"
      assert_select "input#vehicle_unsubscribe", :name => "vehicle[unsubscribe]"
    end
  end
end
