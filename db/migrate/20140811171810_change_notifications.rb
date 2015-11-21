class ChangeNotifications < ActiveRecord::Migration
  def up
    change_table :notifications do |t|
		t.integer :contact_id
		
		t.foreign_key :contacts
	end
	
	remove_foreign_key(:notifications, name: 'notifications_source_id_fk')
	remove_foreign_key(:notifications, name: 'notifications_destination_id_fk')

	remove_column :notifications, :source_id
  	remove_column :notifications, :destination_id
  end
  
  def down
    change_table :notifications do |t|
		t.integer :source_id
		t.integer :destination_id
		
		t.foreign_key :peers, column: 'source_id'
		t.foreign_key :peers, column: 'destination_id'
	end
  end
end
