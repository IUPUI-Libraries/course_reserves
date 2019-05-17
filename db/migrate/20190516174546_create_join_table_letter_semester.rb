class CreateJoinTableLetterSemester < ActiveRecord::Migration[5.1]
  def change
    create_join_table :letters, :semesters do |t|
      t.index [:letter_id, :semester_id]
      # t.index [:semester_id, :letter_id]
    end
  end
end
