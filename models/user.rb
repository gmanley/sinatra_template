require 'digest/sha1'
require 'dm-validations'
require 'dm-timestamps'

class User
  include DataMapper::Resource

  property :id, Serial
  property :login,    String,   :key => true, :length => (3..40), :required => true
  property :hashed_password,  String
  property :salt,   String
  property :created_at, DateTime

  validates_present :login

  def random_string(len)
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    str = ""
    1.upto(len) { |i| str << chars[rand(chars.size-1)] }
    return str
  end

  def password=(pass)
    @password = pass
    self.salt = random_string(10) unless self.salt
    self.hashed_password = User.encrypt(@password, self.salt)
  end

  def self.encrypt(pass, salt)
    Digest::SHA1.hexdigest(pass + salt)
  end

  def self.authenticate(login, pass)
    u = User.first(:login => login )
    return nil if u.nil?
    return u if User.encrypt(pass, u.salt) == u.hashed_password
    nil
  end
end