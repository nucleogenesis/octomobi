class AddPreviewUrlToSites < ActiveRecord::Migration
  def change
    add_column :sites, :preview_url, :string, :default => :null
  end
end
