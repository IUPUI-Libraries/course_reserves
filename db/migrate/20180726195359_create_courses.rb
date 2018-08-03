class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :name
      t.string :course_number
      t.string :instructor
      t.string :instructor_username
      t.string :library
      t.string :semester

      t.timestamps
    end
  end
end
