require 'rails_helper'

RSpec.describe "letters/edit", type: :view do
  before(:each) do
    @letter = assign(:letter, Letter.create!(
      :send_option => "MyString",
      :recipient => "MyText",
      :library => FactoryBot.create(:library),
      :message => "MyText"
    ))
  end

  it "renders the edit letter form" do
    render

    assert_select "form[action=?][method=?]", letter_path(@letter), "post" do

      # assert_select "input[name=?]", "letter[send_option]"
      #
      # assert_select "textarea[name=?]", "letter[recipient]"
      #
      # assert_select "select[name=?]", "letter[library_id]"

      assert_select "textarea[name=?]", "letter[message]"
    end
  end
end
