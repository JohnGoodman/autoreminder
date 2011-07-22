require "spec_helper"

describe ServiceRemindersController do
  describe "routing" do

    it "routes to #index" do
      get("/service_reminders").should route_to("service_reminders#index")
    end

    it "routes to #new" do
      get("/service_reminders/new").should route_to("service_reminders#new")
    end

    it "routes to #show" do
      get("/service_reminders/1").should route_to("service_reminders#show", :id => "1")
    end

    it "routes to #edit" do
      get("/service_reminders/1/edit").should route_to("service_reminders#edit", :id => "1")
    end

    it "routes to #create" do
      post("/service_reminders").should route_to("service_reminders#create")
    end

    it "routes to #update" do
      put("/service_reminders/1").should route_to("service_reminders#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/service_reminders/1").should route_to("service_reminders#destroy", :id => "1")
    end

  end
end
