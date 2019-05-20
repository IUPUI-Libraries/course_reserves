class AddSubjectToLetters < ActiveRecord::Migration[5.1]
  def change
    add_column :letters, :subject, :string
  end
end
