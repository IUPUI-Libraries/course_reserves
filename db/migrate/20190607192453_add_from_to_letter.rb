class AddFromToLetter < ActiveRecord::Migration[5.1]
  def change
    add_column :letters, :from, :string
  end
end
