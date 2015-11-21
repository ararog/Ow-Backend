class CreatePeers < ActiveRecord::Migration
  def up
    create_table :peers do |t|
		t.integer :user_id
		t.string :address

		t.foreign_key :users
	end
  end
  
  
  def down
	drop_table :peers  
  end
end
