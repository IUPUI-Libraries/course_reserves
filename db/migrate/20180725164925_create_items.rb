class CreateItems < ActiveRecord::Migration[5.1]
  def change
    create_table :items do |t|
      t.string :title
      t.string :author
      t.string :publication_date
      t.string :publisher
      t.string :edition
      t.string :loan_period
      t.string :owner
      t.string :call_number
      t.string :note
      t.integer :iucat_id
      t.string :bod_format

      t.timestamps
    end
  end
end
