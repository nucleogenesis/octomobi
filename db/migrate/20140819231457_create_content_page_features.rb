class CreateContentPageFeatures < ActiveRecord::Migration
  def change
    create_table :content_page_features do |t|
      t.string :title
      t.string :slug
      t.text :content

      t.timestamps
    end
  end
end
