class AddDesktopUrlToSites < ActiveRecord::Migration
  def change
    add_column :sites, :desktop_url, :string
  end
end
