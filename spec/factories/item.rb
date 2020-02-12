FactoryBot.define do
  factory :item do
    course
    item_status
    loan_period
    title { "The Title" }
    author { "The Author" }
    publication_date { "2020-02-10" }
  end
end
