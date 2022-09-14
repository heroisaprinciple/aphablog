require 'bcrypt'

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_many :articles

  validates :username, presence: true, uniqueness: true, length: { minimum: 3, maximum: 25}
  validates :email, presence: true, uniqueness: true, length: { maximum: 105 }
  validates_format_of :email, with: /\w+@[a-z]+.[comnetorg]+/, message: "only characters are allowed after @"

  has_secure_password(validations: false)

end
