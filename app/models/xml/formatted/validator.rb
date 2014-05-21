class XML::Formatted::Validator
  attr_reader :messages

  def initialize
    @valid = nil
    @messages = nil
  end

  def validate(root)
    raise ArgumentError, "invalid class of argument passed to #{self.class.name}.validate method" unless root.is_a?(XML::Formatted::Element)

    valid = true
    @valid = false
    @messages = {}

    root.traverse_dfs do |node, _, _|

      if node.is_a?(XML::Formatted::Element)
        valid = false unless node.validate(self)
        next
      end

      next if node.is_a?(XML::Formatted::Data) || node.is_a?(XML::Formatted::Entity)

      add(nil, :invalid_node_class)
      valid = false

    end
    @valid = valid
  end

  def valid?
    !!@valid
  end

  def add(element, message, options={})
    message = generate_message(element, message, options) if message.is_a?(Symbol)
    @messages[element] = [] unless @messages.has_key?(element)
    @messages[element].push(message)
    puts @messages.inspect
  end

  def generate_message(element, type, options={})
    klass = element.nil? ? nil : element.class
    until klass.nil?
      if klass.respond_to? :i18n_key
        begin
          return I18n.translate! type, options.merge(scope: klass.i18n_key)
        rescue I18n::MissingTranslationData
        end
      end
      klass = klass.superclass
    end
    I18n.translate type, options.merge(scope: XML::Formatted::Element.i18n_key)
  end

  module Helper
    module ClassMethods
      def get_allowed_attrs
        @allowed_attrs
      end

      protected

      def allowed_attrs(*attrs)
        @allowed_attrs = attrs
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    protected

    def validate_rule(validator, message, &rule)
      result = !!instance_eval(&rule)
      validator.add(self, message) unless result
      result
    end

    def validate_attrs(validator)
      if self.class.get_allowed_attrs.nil?
        allowed = []
      else
        allowed = self.class.get_allowed_attrs
      end
      result = true
      @attrs.keys.each do |attr|
        unless allowed.include?(attr)
          validator.add(self, :disallowed_attr, attr: attr)
          result = false
        end
      end
      result
    end
  end
end