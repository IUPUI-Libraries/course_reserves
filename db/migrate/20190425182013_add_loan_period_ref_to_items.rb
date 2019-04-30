class AddLoanPeriodRefToItems < ActiveRecord::Migration[5.1]
  def change
    add_reference :items, :loan_period, foreign_key: true
  end
end
