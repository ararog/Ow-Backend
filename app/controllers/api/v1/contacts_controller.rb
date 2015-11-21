class Api::V1::ContactsController < ApplicationController
	
	respond_to :json
	
	def index
		
		@contacts = Contact.where(:user_id => params[:user_id])
	
		respond_to do |format|
			format.json  { render :json => @contacts }
		end
	end
	
	def sync
		
		@user = User.find(params[:user_id])
		
		if params[:_json] then
			
			params[:_json].each do |device_contact| 
				
				formatted_phone_number = device_contact[:phone_number]
				
				phone_number = PhonyRails.normalize_number(formatted_phone_number)

				@person = nil
				
				if formatted_phone_number.include? '+'
					@persons = User.where("country_code || phone_number = :phone_number",
						{phone_number: phone_number})
					
					if @persons.count == 1
						@person = @persons.first
					end
				else
					@persons = User.where("country_code = :country_code AND phone_number LIKE '%' || :phone_number",
						{country_code: @user.country_code, phone_number: phone_number})

					if @persons.count == 1
						@person = @persons.first
					end	

					if @persons.count > 1
						user_country_code = PhonyRails.normalize_number(@user.country_code)
						user_phone_number = PhonyRails.normalize_number(@user.phone_number)
						
						area_code = phone_number[/#{user_country_code}(.*?)#{user_phone_number}/m, 1]

						@persons = User.where("country_code = :country_code AND phone_number = '%' || :area_code || :phone_number",
							{country_code: @user.country_code, area_code: area_code, phone_number: phone_number})

						if @persons.count == 1
							@person = @persons.first
						end	
					end
				end
				
				if @person
					@contacts = Contact.where("user_id = :user_id AND person_id = :person_id",
						{user_id: @user.id, person_id: @person.id})
					
					if @contacts.count == 0
						@contact = Contact.new
						@contact.user = @user
						@contact.person_id = @person.id
						@contact.first_name = device_contact[:first_name]
						@contact.last_name = device_contact[:last_name]
						@contact.save
					end
				end
			end
		end
		
		@contacts = Contact.where(:user_id => @user.id)
	
		json = Jbuilder.encode do |json| 
			json.array! @contacts do |contact|
				json.id contact.id
				json.first_name contact.first_name
				json.last_name contact.last_name
				json.country_code contact.person.country_code
				json.phone_number contact.person.phone_number
			end
		end	
		
		render :json => json
	end
end