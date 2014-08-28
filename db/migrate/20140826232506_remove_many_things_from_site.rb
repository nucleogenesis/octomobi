class RemoveManyThingsFromSite < ActiveRecord::Migration
  def change
    remove_column :sites, :basic_redirect, :string
    remove_column :sites, :pro_redirect, :string
    remove_column :sites, :logo_location, :string
    remove_column :sites, :preview_url, :string
  end
end
