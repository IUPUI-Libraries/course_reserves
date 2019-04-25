class RemoveLibraryFromCourse < ActiveRecord::Migration[5.1]
  def change
    remove_column :courses, :library
  end
end
