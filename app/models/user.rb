class User < ApplicationRecord
  has_many :links
  has_secure_password
  
  validates_presence_of :email, :password, :password_confirmation

end
