class ChangeFirstLastNameContacts < ActiveRecord::Migration

	def up
		change_column :contacts, :first_name, :string, :limit => 100
		change_column :contacts, :last_name, :string, :limit => 100
	end  
  
	def down
		change_column :contacts, :first_name, :string, :limit => 255
		change_column :contacts, :last_name, :string, :limit => 255
	end  
	
end
