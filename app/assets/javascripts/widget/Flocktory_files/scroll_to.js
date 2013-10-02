h.scroll_to = function(element, options) {

  if (!element.length) { return; }

  options = options || {};

  var scrollTop = element.offset()['top'] + (options['offset'] || -20);

  $('html,body').animate(
      { 'scrollTop': scrollTop },
      500,
      options['callback']
  );

};
