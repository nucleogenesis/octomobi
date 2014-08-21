class CreateIntroductionFeatures < ActiveRecord::Migration
  def change
    create_table :introduction_features do |t|
      t.text :content

      t.timestamps
    end
  end
end
