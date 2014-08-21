class CreateSites < ActiveRecord::Migration
	def change
		drop_table :sites

		create_table :sites do |t|
			t.integer :customer_id
			t.string :basic_redirect
			t.string :pro_redirect
			t.string :google_analytics_api_key

			t.timestamps
		end
	end
end
