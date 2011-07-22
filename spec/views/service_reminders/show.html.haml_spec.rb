require 'spec_helper'

describe "service_reminders/show.html.haml" do
  before(:each) do
    @service_reminder = assign(:service_reminder, stub_model(ServiceReminder,
      :name => "Name",
      :description => "MyText",
      :email_subject => "Email Subject",
      :email_body => "Email Body"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email Subject/)
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Email Body/)
  end
end
