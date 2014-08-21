class AddTitleToIntroductionFeature < ActiveRecord::Migration
  def change
    add_column :introduction_features, :title, :string
  end
end
