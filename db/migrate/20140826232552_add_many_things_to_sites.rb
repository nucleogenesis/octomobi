class AddManyThingsToSites < ActiveRecord::Migration
  def change
    add_column :sites, :slug, :string
    add_column :sites, :logo_url, :string
    add_column :sites, :site_type, :string
    add_column :sites, :template, :string
  end
end
