# Seed file for course reserves item_status table
ItemStatus.destroy_all

ItemStatus.create(status: 'Pending')
ItemStatus.create(status: 'Ordering')
ItemStatus.create(status: 'Available')
ItemStatus.create(status: 'Expired')
