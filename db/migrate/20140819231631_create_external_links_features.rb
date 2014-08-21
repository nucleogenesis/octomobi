class CreateExternalLinksFeatures < ActiveRecord::Migration
  def change
    create_table :external_links_features do |t|
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
