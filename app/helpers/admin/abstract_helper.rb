module Admin::AbstractHelper
  def validation_errors(*objects)
    title_msg = objects.extract_options!.fetch(:title) { t('.validation_errors', default: t('errors.title_message')) }
    objects = objects.select { |object| !object.nil? && object.errors.any? }
    if objects.size > 0
      render partial: 'admin/validation_errors', locals: {
          title_msg: title_msg,
          messages: objects.flat_map { |object| object.errors.full_messages }
      }
    else
      nil
    end
  end

  def glyphicon(name, options = {})
    options[:class] = "glyphicon glyphicon-#{h(name)} " + options.fetch(:class, '')
    content_tag :span, '', options
  end

  def action_button_to(url, options = {})
    glyphicon = options.delete(:glyphicon)
    glyphicon = glyphicon.nil? ? '' : " glyphicon glyphicon-#{h(glyphicon)}"
    type = options.delete(:type)
    type = type.nil? ? '' : " btn-#{h(type)}"
    options[:class] = options.fetch(:class, '') + glyphicon + ' btn btn-action x-small' + type
    link_to '', url, options
  end
end