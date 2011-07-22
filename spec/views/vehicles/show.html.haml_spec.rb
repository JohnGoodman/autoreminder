require 'spec_helper'

describe "vehicles/show.html.haml" do
  before(:each) do
    @vehicle = assign(:vehicle, stub_model(Vehicle,
      :year => 1,
      :make => "Make",
      :model => "Model",
      :email => "Email",
      :unsubscribe => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Make/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Model/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
  end
end
