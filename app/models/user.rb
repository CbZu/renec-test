class User < ApplicationRecord
  has_many :video
  has_secure_password
end
