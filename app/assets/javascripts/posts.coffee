# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  $(window).scroll ->
    if $(document).scrollTop() > 100
      $('#nav').addClass 'shrink'
    else
      $('#nav').removeClass 'shrink'
    return
  return
  $(document).ready(ready)
  $(document).on('page:load', ready)


