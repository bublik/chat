$('#features').each(function() {
  var container = $(this),
      $window = $(window),
      submenu = $('.submenu_wrapper'),
      submenu_top = submenu.offset().top;

  $(window).bind('scroll', _.throttle(function() {
    submenu.toggleClass(
      'fixed',
      $window.scrollTop() > submenu_top
    );
  }, 30));

  container.find('#features-menu').onePageNav({
    scrollOffset: submenu.height() + 10
  });

  $('#scroll_to_top').click(function() {
    $('html,body').animate({
      'scrollTop': 0
    }, 300);
  });
});
