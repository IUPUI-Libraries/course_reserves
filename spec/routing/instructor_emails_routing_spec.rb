require "rails_helper"

RSpec.describe InstructorEmailsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(:get => "/instructor_emails").to route_to("instructor_emails#index")
    end

    it "routes to #new" do
      expect(:get => "/instructor_emails/new").to route_to("instructor_emails#new")
    end

    it "routes to #show" do
      expect(:get => "/instructor_emails/1").to route_to("instructor_emails#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/instructor_emails/1/edit").to route_to("instructor_emails#edit", :id => "1")
    end


    it "routes to #create" do
      expect(:post => "/instructor_emails").to route_to("instructor_emails#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/instructor_emails/1").to route_to("instructor_emails#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/instructor_emails/1").to route_to("instructor_emails#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/instructor_emails/1").to route_to("instructor_emails#destroy", :id => "1")
    end
  end
end
