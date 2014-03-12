class User < ActiveRecord::Base
  attr_accessible :active, :email, :guardian_id, :password_digest, :role
end
