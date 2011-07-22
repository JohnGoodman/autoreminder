require "spec_helper"

describe CustomerServiceRemindersController do
  describe "routing" do

    it "routes to #index" do
      get("/customer_service_reminders").should route_to("customer_service_reminders#index")
    end

    it "routes to #new" do
      get("/customer_service_reminders/new").should route_to("customer_service_reminders#new")
    end

    it "routes to #show" do
      get("/customer_service_reminders/1").should route_to("customer_service_reminders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/customer_service_reminders/1/edit").should route_to("customer_service_reminders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/customer_service_reminders").should route_to("customer_service_reminders#create")
    end

    it "routes to #update" do
      put("/customer_service_reminders/1").should route_to("customer_service_reminders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/customer_service_reminders/1").should route_to("customer_service_reminders#destroy", :id => "1")
    end

  end
end
