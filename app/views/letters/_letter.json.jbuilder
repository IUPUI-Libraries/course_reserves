json.extract! letter, :id, :send_option, :recipient, :library, :message, :sent_date, :created_at, :updated_at
json.url letter_url(letter, format: :json)
