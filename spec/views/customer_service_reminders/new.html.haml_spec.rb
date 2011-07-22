require 'spec_helper'

describe "customer_service_reminders/new.html.haml" do
  before(:each) do
    assign(:customer_service_reminder, stub_model(CustomerServiceReminder,
      :person_id => 1,
      :service_reminder_id => 1,
      :reminder_interval => 1,
      :recurring => false,
      :times_sent => 1,
      :max_send => 1
    ).as_new_record)
  end

  it "renders new customer_service_reminder form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => customer_service_reminders_path, :method => "post" do
      assert_select "input#customer_service_reminder_person_id", :name => "customer_service_reminder[person_id]"
      assert_select "input#customer_service_reminder_service_reminder_id", :name => "customer_service_reminder[service_reminder_id]"
      assert_select "input#customer_service_reminder_reminder_interval", :name => "customer_service_reminder[reminder_interval]"
      assert_select "input#customer_service_reminder_recurring", :name => "customer_service_reminder[recurring]"
      assert_select "input#customer_service_reminder_times_sent", :name => "customer_service_reminder[times_sent]"
      assert_select "input#customer_service_reminder_max_send", :name => "customer_service_reminder[max_send]"
    end
  end
end
