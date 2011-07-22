require 'spec_helper'

describe "service_reminders/index.html.haml" do
  before(:each) do
    assign(:service_reminders, [
      stub_model(ServiceReminder,
        :name => "Name",
        :description => "MyText",
        :email_subject => "Email Subject",
        :email_body => "Email Body"
      ),
      stub_model(ServiceReminder,
        :name => "Name",
        :description => "MyText",
        :email_subject => "Email Subject",
        :email_body => "Email Body"
      )
    ])
  end

  it "renders a list of service_reminders" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email Subject".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Email Body".to_s, :count => 2
  end
end
