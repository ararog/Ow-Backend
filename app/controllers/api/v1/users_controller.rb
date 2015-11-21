class Api::V1::UsersController < ApplicationController

	respond_to :json

	def login
		
		@user = User.where("country_code = :country_code AND phone_number = :phone_number",
			{country_code: params[:country_code], phone_number: params[:phone_number]}).first		
		
		if @user 
			json = Jbuilder.encode do |json| 
				json.id @user.id
				json.phone_number @user.phone_number
				json.first_name @user.first_name
				json.last_name @user.last_name
				json.country_code @user.country_code
			end

			render :json => json
		else
			render :status => 404, :json => {:message => "invalid.credentials"}
		end		
	end
	
	def verify
		@user = User.new()
		@user.phone_number = params[:phone_number]
		@user.first_name = params[:first_name]
		@user.last_name  = params[:last_name]
		@user.country_code = params[:country_code]

		if params[:code] == '1234'
			if @user.save
				json = Jbuilder.encode do |json| 
					json.id @user.id
					json.phone_number @user.phone_number
					json.first_name @user.first_name
					json.last_name @user.last_name
					json.country_code @user.country_code
				end

				render :json => json
 			end
		else
			render :status => 500, :json => {:message => "cannot.verify.user"}
		end
	end
	
end
