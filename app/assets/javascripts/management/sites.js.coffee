jQuery ->
  $('.nav-tabs a').on 'click', (e) ->
    e.preventDefault()
    $(this).tab('show')
  $('.nav-tabs a:first').tab('show')
  $('.color').css('background', $('#site_color').val())
  $('#site_color').on 'change', (e)->
    $('.color').css('background', $(this).val())
