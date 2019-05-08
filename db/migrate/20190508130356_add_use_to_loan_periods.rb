class AddUseToLoanPeriods < ActiveRecord::Migration[5.1]
  def change
    add_column :loan_periods, :use, :string
  end
end
