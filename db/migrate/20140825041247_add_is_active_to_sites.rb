class AddIsActiveToSites < ActiveRecord::Migration
  def change
    add_column :sites, :is_active, :boolean
  end
end
