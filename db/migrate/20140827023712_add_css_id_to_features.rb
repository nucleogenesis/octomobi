class AddCssIdToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :css_id, :string
  end
end
