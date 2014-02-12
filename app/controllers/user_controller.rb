class UserController < ApplicationController
	respond_to :json

	require 'json'

	def login
		user = params[:user]
		password = params[:password]
		result = login(user,password)
		return result.to_json
	end  

	def add
		user = params[:user]
		password = params[:password]
		result = add(user, password)	
		return result.to_json
	end 	

	def TESTAPI_resetFixture
    	respond_to do |var|
     	 User.delete_all
      	var.json { render :json => { errCode: SUCCESS } }
   		 end
  	end

end
