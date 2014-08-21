class DeviseCreateGuests < ActiveRecord::Migration
  def change
    create_table(:guests) do |t|
      ## Database authenticatable
      t.string :email,              null: false, default: ""
      t.string :encrypted_password, null: false, default: ""
	  t.string :preview_url,		default: :null

      t.timestamps
    end

    add_index :guests, :email,                unique: true
    # add_index :guests, :confirmation_token,   unique: true
    # add_index :guests, :unlock_token,         unique: true
  end
end
