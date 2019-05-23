require 'rails_helper'

RSpec.describe "Letters", type: :request do
  describe "GET /letters" do
    it "works! (now write some real specs)" do
      get letters_path
      expect(response).to have_http_status(200)
    end
  end
end
