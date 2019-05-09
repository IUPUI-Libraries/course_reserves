require 'rails_helper'

RSpec.describe "InstructorEmails", type: :request do
  describe "GET /instructor_emails" do
    it "works! (now write some real specs)" do
      get instructor_emails_path
      expect(response).to have_http_status(200)
    end
  end
end
