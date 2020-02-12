require 'rails_helper'

RSpec.describe "letters/new", type: :view do
  before(:each) do
    assign(:letter, Letter.new(
      :send_option => "MyString",
      :recipient => "MyText",
      :library => FactoryBot.create(:library),
      :message => "MyText"
    ))
  end

  it "renders new letter form" do
    render

    assert_select "form[action=?][method=?]", letters_path, "post" do

      # assert_select "input[name=?]", "letter[send_option]"

      # assert_select "textarea[name=?]", "letter[recipient]"

      # assert_select "input[name=?]", "letter[library]"

      assert_select "textarea[name=?]", "letter[message]"
    end
  end
end
