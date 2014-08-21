class CreateImageGalleryFeatures < ActiveRecord::Migration
  def change
    create_table :image_gallery_features do |t|
      t.string :title

      t.timestamps
    end
  end
end
