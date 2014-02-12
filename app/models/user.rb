class User < ActiveRecord::Base
@@SUCCESS = 1
@@ERR_BAD_CREDENTIALS = -1
@@ERR_USER_EXISTS = -2
@@ERR_BAD_USERNAME = -3
@@ERR_BAD_PASSWORD = -4
@@MAX_USERNAME_LENGTH = 128
@@MAX_PASSWORD_LENGTH = 128

def self.add (username, password)
	if (username == nil || username.to_s.length > @@MAX_USERNAME_LENGTH)
	 return {errCode: @@ERR_BAD_USERNAME}
	end
	
	if (password.to_s.length > @@MAX_PASSWORD_LENGTH) 
		return {errCode: @@ERR_BAD_PASSWORD}
	end

	if ((User.find_by username: username) == nil)
		User.create(:password => password, :username =>username, :count => 1)
		return {errCode: @@SUCCESS, count: 1}# what else to i return -  http status!?!?!!!
	else 
		return {errCode: @@ERR_USER_EXISTS}
	end
end
	

def self.login(username, password)
	c = User.find_by username: username
	if (c != nil && c.password.to_s == password.to_s)
		c.count += 1
		c.save
		return {errCode: @@SUCCESS, count: c.count}
	else 
		return {errCode: @@ERR_BAD_CREDENTIALS}
	end
end


def self.TESTAPI_resetFixture
	 respond_to do |var|
      User.delete_all  ##the ids dont reset!
      var.json { render :json => { errCode: SUCCESS } }
    end
  end


end
