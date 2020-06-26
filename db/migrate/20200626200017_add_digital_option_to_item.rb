class AddDigitalOptionToItem < ActiveRecord::Migration[5.1]
  def change
    add_column :items, :digital_option, :boolean
    add_column :items, :digital_title, :string
    add_column :items, :digital_url, :string
  end
end
