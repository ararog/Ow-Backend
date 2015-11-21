class Contact < ActiveRecord::Base
	
	belongs_to :user
	
	belongs_to :person, class_name: User
	
end
