class AddSiteIdToContactFeature < ActiveRecord::Migration
  def change
    add_column :contact_features, :site_id, :integer
    add_column :content_page_features, :site_id, :integer
    add_column :external_links_features, :site_id, :integer
    add_column :image_gallery_features, :site_id, :integer
    add_column :introduction_features, :site_id, :integer
    add_column :rss_feed_features, :site_id, :integer
    add_column :social_links_features, :site_id, :integer
  end
end
