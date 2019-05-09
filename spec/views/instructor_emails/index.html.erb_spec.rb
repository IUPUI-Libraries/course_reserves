require 'rails_helper'

RSpec.describe "instructor_emails/index", type: :view do
  before(:each) do
    assign(:instructor_emails, [
      InstructorEmail.create!(
        :send_option => "",
        :semester => "",
        :instuctors => "",
        :library => "",
        :message => ""
      ),
      InstructorEmail.create!(
        :send_option => "",
        :semester => "",
        :instuctors => "",
        :library => "",
        :message => ""
      )
    ])
  end

  it "renders a list of instructor_emails" do
    render
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
