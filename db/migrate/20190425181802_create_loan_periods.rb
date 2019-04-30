class CreateLoanPeriods < ActiveRecord::Migration[5.1]
  def change
    create_table :loan_periods do |t|
      t.string :length

      t.timestamps
    end
  end
end
