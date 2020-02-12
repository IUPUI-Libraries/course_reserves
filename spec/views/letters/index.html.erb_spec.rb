require 'rails_helper'

RSpec.describe "letters/index", type: :view do
  before(:each) do
    assign(:letters, [
      Letter.create!(
        :send_option => "Send Option",
        :recipient => "MyText",
        :library => FactoryBot.create(:library),
        :message => "MyText"
      ),
      Letter.create!(
        :send_option => "Send Option",
        :recipient => "MyText",
        :library => FactoryBot.create(:library),
        :message => "MyText"
      )
    ])
  end

  it "renders a list of letters" do
    # render
    # assert_select "tr>td", :text => "Send Option".to_s, :count => 2
    # assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # assert_select "tr>td", :text => "".to_s, :count => 2
    # assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
