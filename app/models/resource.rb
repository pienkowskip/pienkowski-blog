class Resource < ActiveRecord::Base
  belongs_to :directory

  strip_attributes
end
