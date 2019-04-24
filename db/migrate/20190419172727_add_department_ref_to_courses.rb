class AddDepartmentRefToCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :department, foreign_key: true
  end
end
