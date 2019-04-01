class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :password, :username, :email, presence: true


end
