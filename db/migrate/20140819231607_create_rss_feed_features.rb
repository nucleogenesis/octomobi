class CreateRssFeedFeatures < ActiveRecord::Migration
  def change
    create_table :rss_feed_features do |t|
      t.string :title
      t.string :feed_url
      t.integer :entries_to_show

      t.timestamps
    end
  end
end
