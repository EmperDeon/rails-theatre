zoom_in = ->
  img = $('span.glyphicon.glyphicon-zoom-in.image-zoom').parent().find('.img-response')
  img.css({
    height: '+=' + img.height() * 0.2,
    width: '+=' + img.width() * 0.2
  })

zoom_out = ->
  img = $('span.glyphicon.glyphicon-zoom-out.image-zoom').parent().find('.img-response')
  img.css({
    height: '-=' + img.height() * 0.2,
    width: '-=' + img.width() * 0.2
  })

$(document).on('click', 'span.image-zoom.glyphicon.glyphicon-zoom-in', zoom_in)
$(document).on('click', 'span.image-zoom.glyphicon.glyphicon-zoom-out', zoom_out)
