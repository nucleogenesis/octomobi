class AddOrderToAllFeatures < ActiveRecord::Migration
  def change
    add_column :introduction_features, :order, :integer
    add_column :content_page_features, :order, :integer
    add_column :contact_features, :order, :integer
    add_column :rss_feed_features, :order, :integer
    add_column :external_links_features, :order, :integer
    add_column :image_gallery_features, :order, :integer
    add_column :gallery_images, :order, :integer
  end
end
