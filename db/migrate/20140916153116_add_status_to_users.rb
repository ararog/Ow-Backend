class AddStatusToUsers < ActiveRecord::Migration
  
	def up
		change_table :users do |t|
			t.string :status, :limit => 1
		end
		
		change_column :users, :first_name, :string, :limit => 100
		change_column :users, :last_name, :string, :limit => 100
		change_column :users, :country_code, :string, :limit => 10
		change_column :users, :phone_number, :string, :limit => 30
	end  
  
	def down
		remove_column :users, :status

		change_column :users, :first_name, :string, :limit => 255
		change_column :users, :last_name, :string, :limit => 255
		change_column :users, :country_code, :string, :limit => 255
		change_column :users, :phone_number, :string, :limit => 255
	end  
end
