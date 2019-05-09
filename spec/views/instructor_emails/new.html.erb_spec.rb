require 'rails_helper'

RSpec.describe "instructor_emails/new", type: :view do
  before(:each) do
    assign(:instructor_email, InstructorEmail.new(
      :send_option => "",
      :semester => "",
      :instuctors => "",
      :library => "",
      :message => ""
    ))
  end

  it "renders new instructor_email form" do
    render

    assert_select "form[action=?][method=?]", instructor_emails_path, "post" do

      assert_select "input[name=?]", "instructor_email[send_option]"

      assert_select "input[name=?]", "instructor_email[semester]"

      assert_select "input[name=?]", "instructor_email[instuctors]"

      assert_select "input[name=?]", "instructor_email[library]"

      assert_select "input[name=?]", "instructor_email[message]"
    end
  end
end
