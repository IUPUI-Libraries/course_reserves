class AddPurchaseToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :purchase, :boolean
  end
end
