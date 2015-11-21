class CreateContacts < ActiveRecord::Migration
	
  def up
    create_table :contacts do |t|
		t.integer :user_id
		t.integer :person_id
		
		t.foreign_key :users, column: 'user_id'
		t.foreign_key :users, column: 'person_id'
	end
  end  
  
  def down
	drop_table :contacts  
  end
  
end
