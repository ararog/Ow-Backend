class ChangesToUsersAndContacts < ActiveRecord::Migration
	def up
		change_table :contacts do |t|
			t.string :first_name
			t.string :last_name
		end
		
		remove_column :users, :username
		remove_column :users, :password
	end  
  
	def down
		change_table :contacts do |t|
			t.string :usernane
			t.string :password
		end
		
		remove_column :contacts, :first_name
		remove_column :contacts, :last_name
	end
end
