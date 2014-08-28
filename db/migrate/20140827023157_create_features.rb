class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :title
      t.string :image
      t.boolean :is_active

      t.timestamps
    end
  end
end
