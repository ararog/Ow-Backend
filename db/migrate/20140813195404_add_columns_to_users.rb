class AddColumnsToUsers < ActiveRecord::Migration
	def up
		change_table :users do |t|
			t.string :first_name
			t.string :last_name
			t.string :country_code
		end
	end  
  
	def down
		remove_column :users, :first_name
		remove_column :users, :last_name
		remove_column :users, :country_code
	end
end
