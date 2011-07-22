require 'spec_helper'

describe "vehicles/index.html.haml" do
  before(:each) do
    assign(:vehicles, [
      stub_model(Vehicle,
        :year => 1,
        :make => "Make",
        :model => "Model",
        :email => "Email",
        :unsubscribe => false
      ),
      stub_model(Vehicle,
        :year => 1,
        :make => "Make",
        :model => "Model",
        :email => "Email",
        :unsubscribe => false
      )
    ])
  end

  it "renders a list of vehicles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Make".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Model".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
