class Directory < ActiveRecord::Base
  has_ancestry
  has_many :resources

  strip_attributes

  validates :name, presence: true, format: /\A[^\/]+\z/, uniqueness: { scope: :ancestry }
  validate :validate_parent

  before_save :render_fullpath

  def parent=(parent)
    super(parent)
    @valid_parent = true
  end

  def parent_id=(id)
    super(id)
    @valid_parent = true
  rescue ActiveRecord::RecordNotFound
    self.parent = nil
    @valid_parent = false
  end

  private

  def fullpath=(fullpath)
    write_attribute :fullpath, fullpath
  end

  def render_fullpath
    return unless ancestry_changed? || name_changed?
    self.fullpath = '/' + ((ancestors.map &:name) << name).join('/')
  end

  def validate_parent
    return if @valid_parent
    errors.add(:parent_id, errors.generate_message(:parent_id, @valid_parent.nil? ? :blank : :invalid))
  end
end
