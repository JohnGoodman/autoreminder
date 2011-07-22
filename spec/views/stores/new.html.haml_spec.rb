require 'spec_helper'

describe "stores/new.html.haml" do
  before(:each) do
    assign(:store, stub_model(Store,
      :name => "MyString",
      :address => "MyString",
      :address_two => "MyString",
      :phone => "MyString",
      :phone_two => "MyString",
      :email => "MyString",
      :fax => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => 1
    ).as_new_record)
  end

  it "renders new store form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stores_path, :method => "post" do
      assert_select "input#store_name", :name => "store[name]"
      assert_select "input#store_address", :name => "store[address]"
      assert_select "input#store_address_two", :name => "store[address_two]"
      assert_select "input#store_phone", :name => "store[phone]"
      assert_select "input#store_phone_two", :name => "store[phone_two]"
      assert_select "input#store_email", :name => "store[email]"
      assert_select "input#store_fax", :name => "store[fax]"
      assert_select "input#store_city", :name => "store[city]"
      assert_select "input#store_state", :name => "store[state]"
      assert_select "input#store_zip", :name => "store[zip]"
    end
  end
end
