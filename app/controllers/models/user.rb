class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password
  validates :password, :username, :email, presence: true

  def slug
    slug = self.username.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
  end

  def self.find_by_slug(slug)
    User.all.find do |user|
      if user.slug == slug
        user
      end
    end
  end
end
