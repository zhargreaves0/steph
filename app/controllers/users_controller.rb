class UsersController < ApplicationController
	respond_to :json

	require 'json'

	def login
		user = params[:user]
		password = params[:password]
		result = login(user,password)
		render :json => result 
	end  

	def add
		user = params[:user]
		password = params[:password]
		result = add(user, password)	
		render :json => result 
	end 	

	def TESTAPI_resetFixture
    	respond_to do |var|
     	 User.delete_all
      	var.json { render :json => { errCode: SUCCESS } }
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
