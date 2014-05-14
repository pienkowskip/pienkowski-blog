class Category < ActiveRecord::Base
  has_many :posts, dependent: :restrict_with_exception, inverse_of: :category

  strip_attributes

  validates :name, :text_id, presence: true
  validates :text_id, format: /\A[0-9a-z_-]+\z/
  validates :text_id, uniqueness: true
end
