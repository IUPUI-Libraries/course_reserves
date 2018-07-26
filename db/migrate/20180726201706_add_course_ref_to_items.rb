class AddCourseRefToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :course, foreign_key: true
  end
end
