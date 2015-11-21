class CreateConnections < ActiveRecord::Migration
  def change
    create_table :connections, id: false do |t|
	  t.string :id, primary: true	
      t.integer :user_id
    end
  end
end
