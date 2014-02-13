class User < ActiveRecord::Base
@@SUCCESS = 1
@@ERR_BAD_CREDENTIALS = -1
@@ERR_USER_EXISTS = -2
@@ERR_BAD_USERNAME = -3
@@ERR_BAD_PASSWORD = -4
@@MAX_USERNAME_LENGTH = 128
@@MAX_PASSWORD_LENGTH = 128

##render(:json => {}, status:500)
#request.headers['Content-Type'].split(';')      .include?(application/json)

#validates :username, presence: true, uniqueness: true, length: {maximum: 128}
#validates :password, presence: true, length: {maximum: 128}   

def self.add (user, password)
	if (user == nil ||user.to_s.length == 0|| user.to_s.length > @@MAX_USERNAME_LENGTH)
	 return @@ERR_BAD_USERNAME
	end
	
	if (password.to_s.length > @@MAX_PASSWORD_LENGTH) 
		return @@ERR_BAD_PASSWORD
	end

	if ((User.find_by user: user) == nil)
		User.create(:password => password, :user =>user, :count => 1)
		return @@SUCCESS# what else to i return -  http status!?!?!!!
	else 
		return @@ERR_USER_EXISTS
	end
end
	

def self.login(user, password)
	c = User.find_by user: user
	if (c != nil && c.password.to_s == password.to_s)
		c.count += 1
		c.save
		return c.count
	else 
		return @@ERR_BAD_CREDENTIALS
	end
end


def self.TESTAPI_resetFixture()
      User.delete_all  ##the ids dont reset!
      return @@SUCCESS
    end
  


end
