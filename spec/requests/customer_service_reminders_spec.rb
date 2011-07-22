require 'spec_helper'

describe "CustomerServiceReminders" do
  describe "GET /customer_service_reminders" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get customer_service_reminders_path
      response.status.should be(200)
    end
  end
end
