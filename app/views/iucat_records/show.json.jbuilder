json.title wrap @record.data['245a']
json.subtitle wrap @record.data['245b']
json.author wrap @record.data['245c']
json.publication_date wrap @record.data['260c']
json.call_number wrap [@record.data['050a'], @record.data['050b']].join(' ')
json.edition wrap @record.data['250a']
json.location wrap @record.data['999m']
json.local_location local @record.data['999m']
json.book_on_demand bod @record.data['999n']
