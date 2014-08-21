class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.integer :image_gallery_feature_id
      t.string :image_location
      t.string :alt
      t.string :link_to

      t.timestamps
    end
  end
end
