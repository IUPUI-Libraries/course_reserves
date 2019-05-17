class CreateLetters < ActiveRecord::Migration[5.1]
  def change
    create_table :letters do |t|
      t.string :send_option
      t.text :recipient
      t.references :library
      t.text :message
      t.datetime :sent_date

      t.timestamps
    end
  end
end
