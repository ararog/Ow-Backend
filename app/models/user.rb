class User < ActiveRecord::Base
	
	has_many :contacts, :foreign_key => 'user_id'
	
	has_one :peer
	
end
