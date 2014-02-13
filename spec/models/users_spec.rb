require 'spec_helper'

## From rails root

##rake db:test:prepare
## rspec spec/

describe User do 
	it "Test Adding a User to db" do 
			expect{User.create({user: "john",password: "Doe"})}.to change{User.count}.by(1)
		end 
end


describe User do 
	it "Test Adding a User to db" do 
			expect{User.create({user: "john",password: "Doe"})}.to change{User.count}.by(1)
		end 
end


describe User do 
	it "Test Adding a User to db" do 
			expect{User.create( "john","l")}.to change{User.count}.by(1)
		end 
end
