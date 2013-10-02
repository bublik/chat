$('#frontpage').each(function() {
  var container = $(this);

  new h.Scroller(
    $('#testimonials_scroller'),
    {
      'left': $('#left_arrow'),
      'right': $('#right_arrow')
    }
  );

  // video
  (function() {
    if (!Modernizr.touch) {
      var button = $('#video_link'),
          video = $('#vimeo_player'),
          player = $f(video[0]);

      var overlay =
        $('<div/>', { 'id': 'frontpage_video_overlay' }).
          appendTo(document.body).
          append(
            $('<div/>', { 'class': 'inner' }).append(
              $('<div/>', { 'class': 'close' }),
              video
            )
          );

      overlay.click(function(e) {
        if (!$(e.target).closest('video').length) {
          overlay.removeClass('visible');
          player.api('pause');
        }
      });

      button.click(function() {
        overlay.addClass('visible');
        setTimeout(function() {
          player.api('play');
        }, 50);
      });

      if (h.show_video_popup) { overlay.addClass('visible'); };
    }
  })();
});
