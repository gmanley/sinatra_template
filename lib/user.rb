class User
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActiveModel::SecurePassword

  field :email,         type: String
  field :password_digest, type: String

  has_secure_password

  attr_accessible :email, :password, :password_confirmation

  EMAIL_REGEX = /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i

  validates :email, presence: true,
                    uniqueness: { case_sensitive: false },
                    format: { with: EMAIL_REGEX }

  def self.authenticate(email, password)
    user = where(email: email).first
    user && user.authenticate(password)
  end
end
