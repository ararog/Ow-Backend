class Api::V1::ConnectionsController < WebsocketRails::BaseController

	include WebsocketRails::Logging

	def channel_subscribe_event
		
		channel = message[:channel]
		
		if channel
			WebsocketRails[channel].filter_with(NotificationsController, 
			                                    catch_all: :notification_event)
		end	
	end
	
	def connected_event
	
		@connection = Connection.new
		@connection.id = client_id
		@connection.user_id = message[:id]
		@connection.save
		
		@person = User.find(@connection.user_id)
		
		if @person
			@person.status = "C"
			@person.save
		end
	end
	
	def disconnected_event
	
		@connections = Connection.where("id = :connection_id",
			{connection_id: client_id})
		
		if @connections.count == 1
			
			@connection = @connections.first
			
			@person = User.find(@connection.user_id)
			
			if @person
				@person.status = "D"
				@person.save
			end
			
			@connection.destroy
		end
	end
end