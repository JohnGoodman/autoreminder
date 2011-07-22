require 'spec_helper'

describe "companies/new.html.haml" do
  before(:each) do
    assign(:company, stub_model(Company,
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

  it "renders new company form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => companies_path, :method => "post" do
      assert_select "input#company_name", :name => "company[name]"
      assert_select "input#company_address", :name => "company[address]"
      assert_select "input#company_address_two", :name => "company[address_two]"
      assert_select "input#company_phone", :name => "company[phone]"
      assert_select "input#company_phone_two", :name => "company[phone_two]"
      assert_select "input#company_email", :name => "company[email]"
      assert_select "input#company_fax", :name => "company[fax]"
      assert_select "input#company_city", :name => "company[city]"
      assert_select "input#company_state", :name => "company[state]"
      assert_select "input#company_zip", :name => "company[zip]"
    end
  end
end
