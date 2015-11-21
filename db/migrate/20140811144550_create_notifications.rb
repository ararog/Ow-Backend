class CreateNotifications < ActiveRecord::Migration

  def up
    create_table :notifications do |t|
		t.integer :source_id
		t.integer :destination_id
		t.integer :type
		t.string :content
		
		t.foreign_key :peers, column: 'source_id'
		t.foreign_key :peers, column: 'destination_id'
	end
  end
  
  def down
	drop_table :notifications  
  end
  
end
