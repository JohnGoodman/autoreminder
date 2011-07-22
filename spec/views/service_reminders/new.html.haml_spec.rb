require 'spec_helper'

describe "service_reminders/new.html.haml" do
  before(:each) do
    assign(:service_reminder, stub_model(ServiceReminder,
      :name => "MyString",
      :description => "MyText",
      :email_subject => "MyString",
      :email_body => "MyString"
    ).as_new_record)
  end

  it "renders new service_reminder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => service_reminders_path, :method => "post" do
      assert_select "input#service_reminder_name", :name => "service_reminder[name]"
      assert_select "textarea#service_reminder_description", :name => "service_reminder[description]"
      assert_select "input#service_reminder_email_subject", :name => "service_reminder[email_subject]"
      assert_select "input#service_reminder_email_body", :name => "service_reminder[email_body]"
    end
  end
end
