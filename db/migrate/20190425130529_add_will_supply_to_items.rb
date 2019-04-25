class AddWillSupplyToItems < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :will_supply, :boolean
  end
end
