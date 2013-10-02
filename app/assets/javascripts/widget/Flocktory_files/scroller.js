h.Scroller = function(element, options) {
  this.element = element;
  this.options = options;

  this.init();
};

h.Scroller.prototype.init = function() {
  _.bindAll(this, 'scroll_left', 'scroll_right');

  var children = this.element.children();

  if (children.length < 4) { return; }

  this.child = children.first();

  this.element.children().clone(true).appendTo(this.element);

  this.options['left'].bind('click', this.scroll_left);
  this.options['right'].bind('click', this.scroll_right);
};

h.Scroller.prototype.scroll_left = function() {
  this.scroll(-1);
};

h.Scroller.prototype.scroll_right = function() {
  this.scroll(1);
};

h.Scroller.prototype.scroll = function(direction) {
  var width = this.element.innerWidth(),
      child_width = this.child.outerWidth(),
      scroll_left = this.element.scrollLeft() + direction,
      max_scroll = this.element[0].scrollWidth - width;

  var to = Math[direction > 0 ? 'ceil' : 'floor'](scroll_left / child_width) * child_width;

  if (to < 0) {
    var middle = this.element[0].scrollWidth / 2;
    this.element.prop('scrollLeft', middle);
    to = middle - child_width;
  }

  if (to > max_scroll) {
    var middle = this.element[0].scrollWidth / 2 - width;
    this.element.prop('scrollLeft', middle);
    to = middle + child_width;
  }

  this.element.stop(true).animate({
    'scrollLeft': to
  }, 300);
};

