require 'rails_helper'

RSpec.describe "letters/show", type: :view do
  before(:each) do
    @letter = assign(:letter, Letter.create!(
      :send_option => "Send Option",
      :recipient => "MyText",
      :library => "",
      :message => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Send Option/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(//)
    expect(rendered).to match(/MyText/)
  end
end
