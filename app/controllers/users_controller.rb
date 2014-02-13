class UsersController < ApplicationController
	respond_to :json

	require 'json'

	def login
		user = params[:user]
		password = params[:password]
		result = User.login(user,password)
		if result > 1
			temp = {errCode: 1, count: result}
		end
		if result == -1 
			temp = {errCode: result}
		end 
		render :json => temp 
	end  

	def add
		user = params[:user]
		password = params[:password]
		result = User.add(user, password)
		if result == 1 
			temp = {errCode: result, count: 1}
		end
		if result != 1 
			temp = {errCode: result}	
		end
		render :json => temp 
	end 	

	def TESTAPI_resetFixture
		if (params.length == 0 || params.length == nil)
    		result = User.TESTAPI_resetFixture
    		temp = {errCode: result}
     	 	render :json => temp 
      		 #passing in empty dictionary? what if passed none empty payload?
   		end
  	end

  	def TESTAPI_unitTests
  		# RAILS_ROOT 
  		a  =  `rspec #{Rails.root}/spec/`
  		a =~ /([0-9]+) examples/
  		totalTests = $1.to_i	
  		a =~ /([0-9]+) failure/
  		nrFailed = $1.to_i	
  		tmp = {nrFailed: nrFailed, output: a, totalTests: totalTests}
  		render :json => tmp 
  	end






 # `rspec --out unitTest.txt`

 #    File.open('unitTest.txt', 'r') do |f|
 #      while line = f.gets
 #        if line.include? "examples" and line.include? "failures"
 #          @outputArray = line.split
 #          @totalTests = @outputArray[0]
 #          @nrFailed = @outputArray[2]
 #        end
 #      end
 #      f.rewind
 #      @output = f.read
 #    end


end
