json.title @record.data['245a'].to_s + @record.data['245b'].to_s
json.author @record.data['245c'].to_s
json.publication_date @record.data['260c'].to_s
json.location @record.data['999m'].to_s
json.book_on_demand @record.data['999n'] == '_ULDEMAND' ? true : false
