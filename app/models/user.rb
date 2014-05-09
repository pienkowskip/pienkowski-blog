class User < ActiveRecord::Base
  authenticates_with_sorcery!

  has_many :posts, foreign_key: :author_id, inverse_of: :author

  strip_attributes except: [:password, :password_confirmation]

  validates :username, :email, presence: true
  validates :username, format: { with: /\A[0-9a-z._-]{3,}\z/}
  validates :email, format: { with: /\A([a-z0-9._%+-]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :username, :email, uniqueness: { case_sensitive: false }

  #validates :password, length: { minimum: 3 }, if: :password
  #validates :password, confirmation: true, if: :password
end
