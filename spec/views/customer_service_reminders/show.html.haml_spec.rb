require 'spec_helper'

describe "customer_service_reminders/show.html.haml" do
  before(:each) do
    @customer_service_reminder = assign(:customer_service_reminder, stub_model(CustomerServiceReminder,
      :person_id => 1,
      :service_reminder_id => 1,
      :reminder_interval => 1,
      :recurring => false,
      :times_sent => 1,
      :max_send => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/false/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/1/)
  end
end
