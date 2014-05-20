class Post < ActiveRecord::Base
  belongs_to :author, class_name: 'User'
  belongs_to :category

  scope :for_category, ->(text_id) { joins(:category).where(categories: {text_id: text_id}) }

  strip_attributes

  before_validation :parse_content

  validates :title, :content, :parsed_content, presence: true
  validates_belongs :author, :category
  #validates_before_type_case :created_at, format: /\A\d{4}\-\d{2}\-\d{2}\ \d{2}\:\d{2}\Z/, allow_blank: true
  #validates_class :created_at, class: [Time, NilClass]

  validates_class :created_at, class: Time, unless: ->(record) { record.created_at_before_type_cast.blank? }

  validate :validate_parsed_content

  after_initialize :init

  before_save :render_parsed_content

  private

  def init
    #hack for proper displaying in forms
    unless created_at.nil?
      @attributes['created_at'] = I18n.l(created_at, format: :datetimepicker)
    end
  end

  def parse_content
    return unless content_changed?
    if content.nil?
      self.parsed_content = nil
      return
    end
    #TODO: Maybe move this to initializer.
    parser = Redcarpet::Markdown.new(
        Redcarpet::Render::XHTML.new(),
        disable_indented_code_blocks: true,
        strikethrough: true,
        underline: true)
    self.parsed_content = XML::Formatted::Tree.new('<root>' + parser.render(content) + '</root>')
  end

  def render_parsed_content
    return unless content_changed?
    raise XML::RenderingError, 'can render only instances of XML::Formatted::Tree' unless self.parsed_content.is_a? XML::Formatted::Tree
    self.parsed_content = self.parsed_content.root.render(nil)
    true
  end

  def validate_parsed_content
    return if parsed_content.nil? || parsed_content.is_a?(String)
    add_error = ->(type=:invalid, options={}) do
      errors.add(:parsed_content, errors.generate_message(:parsed_content, type, options))
    end
    unless parsed_content.is_a? XML::Formatted::Tree
      add_error.call
      return
    end
    tree = parsed_content
    if tree.valid?
      validator = XML::Formatted::Validator.new
      return if validator.validate tree.root
      errors_list = validator.messages.map do |element, messages|
        escaped = messages.map { |msg| ERB::Util.html_escape msg }
        if element.nil?
          escaped
        else
          escaped.map { |msg| "<em>&lt;#{element.name}&gt;</em>: #{msg}" }
        end
      end
      errors_list.flatten!(1)
      add_error.call :validation_errors, errors: errors_list.join('<br />')
    else
      if tree.errors_pipeline.empty?
        add_error.call
      else
        errors_list = (tree.errors_pipeline.map { |e| ERB::Util.html_escape(e.to_s) }).join '<br />'
        add_error.call :parsing_errors, errors: errors_list
      end
    end
  end
end
