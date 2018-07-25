json.extract! item, :id, :title, :author, :publication_date, :status, :publisher, :edition, :loan_period, :owner, :call_number, :note, :iucat_id, :created_at, :updated_at
json.url item_url(item, format: :json)
