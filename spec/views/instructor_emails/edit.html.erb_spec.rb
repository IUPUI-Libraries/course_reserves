require 'rails_helper'

RSpec.describe "instructor_emails/edit", type: :view do
  before(:each) do
    @instructor_email = assign(:instructor_email, InstructorEmail.create!(
      :send_option => "",
      :semester => "",
      :instuctors => "",
      :library => "",
      :message => ""
    ))
  end

  it "renders the edit instructor_email form" do
    render

    assert_select "form[action=?][method=?]", instructor_email_path(@instructor_email), "post" do

      assert_select "input[name=?]", "instructor_email[send_option]"

      assert_select "input[name=?]", "instructor_email[semester]"

      assert_select "input[name=?]", "instructor_email[instuctors]"

      assert_select "input[name=?]", "instructor_email[library]"

      assert_select "input[name=?]", "instructor_email[message]"
    end
  end
end
