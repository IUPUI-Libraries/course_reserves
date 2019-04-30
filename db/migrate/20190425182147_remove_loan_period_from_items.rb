class RemoveLoanPeriodFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :loan_period
  end
end
