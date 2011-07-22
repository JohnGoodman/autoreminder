require 'spec_helper'

describe "stores/index.html.haml" do
  before(:each) do
    assign(:stores, [
      stub_model(Store,
        :name => "Name",
        :address => "Address",
        :address_two => "Address Two",
        :phone => "Phone",
        :phone_two => "Phone Two",
        :email => "Email",
        :fax => "Fax",
        :city => "City",
        :state => "State",
        :zip => 1
      ),
      stub_model(Store,
        :name => "Name",
        :address => "Address",
        :address_two => "Address Two",
        :phone => "Phone",
        :phone_two => "Phone Two",
        :email => "Email",
        :fax => "Fax",
        :city => "City",
        :state => "State",
        :zip => 1
      )
    ])
  end

  it "renders a list of stores" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address Two".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Phone Two".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Fax".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "City".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "State".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
