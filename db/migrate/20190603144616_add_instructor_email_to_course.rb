class AddInstructorEmailToCourse < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :instructor_email, :string
  end
end
