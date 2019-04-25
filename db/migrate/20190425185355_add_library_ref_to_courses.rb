class AddLibraryRefToCourses < ActiveRecord::Migration[5.1]
  def change
    add_reference :courses, :library, foreign_key: true
  end
end
