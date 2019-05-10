class RemoveSemesterIdFromInstructorEmails < ActiveRecord::Migration[5.1]
  def change
    remove_column :instructor_emails, :semester_id
  end
end
