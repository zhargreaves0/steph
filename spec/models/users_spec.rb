require 'spec_helper'

@@SUCCESS = 1
@@ERR_BAD_CREDENTIALS = -1
@@ERR_USER_EXISTS = -2
@@ERR_BAD_USERNAME = -3
@@ERR_BAD_PASSWORD = -4

## From rails root

## rake db:test:prepare
## rspec spec/

describe User do 
	it "Test Adding a User to db" do 
			expect{User.create({user: "john",password: "Doe"})}.to change{User.count}.by(1)
		end 
end


describe User do
	it "Return value of adding a user to a Db" do
		@@SUCCESS.should equal(User.add("user1","password1"))
		(User.count).should equal(1)
	end
end

describe User do
	it "Return value of adding two users to a Db" do
		@@SUCCESS.should equal(User.add("user1","password1"))
		(User.count).should equal(1)
		@@SUCCESS.should equal(User.add("user2","password1"))
		(User.count).should equal(2)

	end
end

describe User do
	it "Checking Adding of Same User incurs and error" do
		c = User.add("user1","password1")
		(User.count).should equal(1)
		@@ERR_USER_EXISTS.should equal(User.add("user1","password1"))
		(User.count).should equal(1)
	end
end


describe User do
	it "Adding a empty username" do
		c = User.add("user1","password1")
		@@ERR_BAD_USERNAME.should equal(User.add("","password1"))
	end
end

describe User do
	it "Excedes max login length" do
		c = User.add("user1","password1")
		@@ERR_BAD_USERNAME.should equal(User.add("flajfljsdfljalksdjfklsdajlkfkafadsfsadfsafasfsfsdfsdsdjkflkasdjflksjflksdfklfjskfklaflkaskvnakfnlafwenkffeoiwiofhjknvighahjvnknvdfgkjnlskdgnfglskngdsfnsfdlkgjsdflkgjsdfl","user1"))
	end
end

describe User do
	it "Excedes max password length" do
		c = User.add("user1","password1")
		(User.count).should equal(1)
		@@ERR_BAD_PASSWORD.should equal(User.add("user1","flajfljsdfljalksfeafasfsfgererfeeafdjfklsdajlkfkasdjkflkasdjflksjflksdfklfjskfklaflkaskvnakfnlafwenkffeoiwiofhjknvighahjvnknvdfgkjnlskdgnfglskngdsfnsfdlkgjsdflkgjsdfl"))
		(User.count).should equal(1)
	end
end

describe User do
	it "Checking Login return statement" do
		c = User.add("user1","password1")
		(User.count).should equal(1)
		(User.login("user1","password1")).should be > 1
	end
end

describe User do
	it "Checking Login with no Prev username" do
		c = User.add("user1","password1")
		(User.count).should equal(1)
		@@ERR_BAD_CREDENTIALS.should equal(User.login("user10","password1"))
	end
end

describe User do
	it "Reset Fixture and add User checks" do
		a = User.add("user1","password1")
		(User.count).should equal(1)
		User.TESTAPI_resetFixture()
		c = User.add("user1","password1")
		d = User.add("user2","password1")
		e = User.add("user3","password1")
		(User.count).should equal(3)
		User.TESTAPI_resetFixture()
		(User.count).should equal(0)
	end
end



# describe User do 
# 	it "Test Adding a User to db2" do 
# 			expect{User.create( "john","l")}.to change{User.count}.by(1)
# 		end 
# end
