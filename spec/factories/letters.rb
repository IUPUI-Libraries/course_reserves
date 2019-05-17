FactoryBot.define do
  factory :letter do
    send_option { "MyString" }
    recipient { "MyText" }
    library { "" }
    message { "MyText" }
    sent_date { "2019-05-16 13:41:41" }
  end
end
