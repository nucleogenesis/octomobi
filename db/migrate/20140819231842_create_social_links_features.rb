class CreateSocialLinksFeatures < ActiveRecord::Migration
  def change
    create_table :social_links_features do |t|
      t.string :twitter_url
      t.string :facebook_url
      t.string :google_plus_url
      t.string :pinterest_url
      t.string :instagram_url
      t.string :linkedin_url

      t.timestamps
    end
  end
end
