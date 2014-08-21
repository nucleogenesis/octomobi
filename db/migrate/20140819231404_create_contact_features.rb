class CreateContactFeatures < ActiveRecord::Migration
  def change
    create_table :contact_features do |t|
      t.string :email_contact
      t.string :phone_contact
      t.string :fax_contact
      t.string :address

      t.timestamps
    end
  end
end
