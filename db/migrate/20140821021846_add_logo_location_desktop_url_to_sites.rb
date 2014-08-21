class AddLogoLocationDesktopUrlToSites < ActiveRecord::Migration
  def change
    add_column :sites, :desktop_site_url, :string
    add_column :sites, :logo_location, :string
  end
end
