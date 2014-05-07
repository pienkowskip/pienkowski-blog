#=require abstract/dialogs

$(document).ready ->
  dropdown = $('#navbar > .dropdown').each ->
    self = $(this)
    self.children('.dropdown-toggle').click (event)->
      event.preventDefault()
      if self.hasClass 'dropdown-open'
        self.removeClass 'dropdown-open'
      else
        dropdown.removeClass 'dropdown-open'
        self.addClass 'dropdown-open'