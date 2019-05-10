class CreateSemesterReferences < ActiveRecord::Migration[5.1]
  def change
    create_table :semester_references do |t|
      t.integer :semester_id
      t.integer :instructor_email_id

      t.timestamps
    end
  end
end
