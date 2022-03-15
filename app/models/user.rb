require 'pp'
class User < ActiveRecord::Base
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, :uniqueness => {:case_sensitive => false}
  validates :password, presence: true, length: {minimum: 6}
  validates :password_confirmation, presence: true, length: { minimum: 6 }
  
  def self.authenticate_with_credentials(email, password)
    pp "here", email, password
    email = email.downcase.strip
    user = self.find_by_email(email)
    pp "user", user, user.authenticate(password)
    if user && user.authenticate(password)
      user
    else
      nil
    end
  end

end
