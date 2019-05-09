class CreateInstructorEmails < ActiveRecord::Migration[5.1]
  def change
    create_table :instructor_emails do |t|
      t.string :send_option
      t.references :semester
      t.string :instuctors
      t.references :library
      t.text :message
      t.datetime :sent_date

      t.timestamps
    end
  end
end
