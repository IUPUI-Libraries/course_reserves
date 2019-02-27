json.title wrap @record.data['245a']
json.subtitle wrap @record.data['245b']
json.author wrap @record.data['245c']
json.publication_date wrap @record.data['260c']
json.location wrap @record.data['999m']
json.local_location (@record.data['999m'] & ['I-UNIVLIB','I-ART']).any? ? true : false
json.book_on_demand @record.data['999n'] == '_ULDEMAND' ? true : false
