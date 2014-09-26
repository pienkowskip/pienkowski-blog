class Category < ActiveRecord::Base
  has_many :posts, dependent: :restrict_with_exception, inverse_of: :category

  strip_attributes

  validates :name, presence: true
  validates :text_id, presence: true, format: /\A[0-9a-z_-]+\z/, uniqueness: true
end
