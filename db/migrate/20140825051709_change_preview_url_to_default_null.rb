class ChangePreviewUrlToDefaultNull < ActiveRecord::Migration
  def change
	  remove_column :sites, :preview_url
	  add_column :sites, :preview_url, :string,  default: nil
  end
end
