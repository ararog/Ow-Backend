class Api::V1::NotificationsController < WebsocketRails::BaseController
	

	def notification_event
		
		Notification.create({type: message.type, 
		                     content: message.content, 
		                     contact_id: message.contact.id})
	end

end
