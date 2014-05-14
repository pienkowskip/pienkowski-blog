class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :category

  strip_attributes

  validates :title, :content, presence: true
  validates_belongs :author, :category
  #validates_before_type_case :created_at, format: /\A\d{4}\-\d{2}\-\d{2}\ \d{2}\:\d{2}\Z/, allow_blank: true
  #validates_class :created_at, class: [Time, NilClass]

  validates_class :created_at, class: Time, unless: ->(record) { record.created_at_before_type_cast.blank? }

  after_initialize :init

  private

  def init
    #hack for proper displaying in forms
    unless created_at.nil?
      @attributes['created_at'] = I18n.l(created_at, format: :datetimepicker)
    end
  end
end
