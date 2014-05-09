#=require jquery
#=require jquery_ujs
#=require jquery.datetimepicker
#=require abstract/dialogs
#=require_self

overrideUJSConfirmation = (confirmFn)->

  confirmed = (element)->
    element.removeAttr('data-confirm')
    element.trigger('click')

  $.rails.allowAction = (element)->
    message = element.attr('data-confirm')
    if (!message)
      return true
    confirmFn(message, element, confirmed)
    return false


$(document).ready ->

  overrideUJSConfirmation (msg, element, callback)->
    dialogBody = $('<div class="dialog-content"></div>')
    $('<div></div>').append(msg).appendTo(dialogBody)
    confirmButton = $('<button class="btn btn-danger small">OK</button>').appendTo(dialogBody)
    cancelButton = $('<button class="btn btn-primary small">Anuluj</button>').appendTo(dialogBody)
    dialog = new ModalDialog('confirm-dialog', t('dialogs.titles.confirm'), dialogBody).show()
    confirmButton.click ->
      callback(element)
      dialog.close()
    cancelButton.click ->
      dialog.close();

  $('input.datetimepicker').datetimepicker(lang: I18n.locale, format: 'Y-m-d H:i')

  dropdown = $('#navbar > .dropdown').each ->
    self = $(this)
    self.children('.dropdown-toggle').click (event)->
      event.preventDefault()
      if self.hasClass 'dropdown-open'
        self.removeClass 'dropdown-open'
      else
        dropdown.removeClass 'dropdown-open'
        self.addClass 'dropdown-open'