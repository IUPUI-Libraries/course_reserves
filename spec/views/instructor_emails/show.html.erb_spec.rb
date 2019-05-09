require 'rails_helper'

RSpec.describe "instructor_emails/show", type: :view do
  before(:each) do
    @instructor_email = assign(:instructor_email, InstructorEmail.create!(
      :send_option => "",
      :semester => "",
      :instuctors => "",
      :library => "",
      :message => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
