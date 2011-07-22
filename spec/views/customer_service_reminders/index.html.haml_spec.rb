require 'spec_helper'

describe "customer_service_reminders/index.html.haml" do
  before(:each) do
    assign(:customer_service_reminders, [
      stub_model(CustomerServiceReminder,
        :person_id => 1,
        :service_reminder_id => 1,
        :reminder_interval => 1,
        :recurring => false,
        :times_sent => 1,
        :max_send => 1
      ),
      stub_model(CustomerServiceReminder,
        :person_id => 1,
        :service_reminder_id => 1,
        :reminder_interval => 1,
        :recurring => false,
        :times_sent => 1,
        :max_send => 1
      )
    ])
  end

  it "renders a list of customer_service_reminders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
