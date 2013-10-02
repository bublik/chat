h.superlabels = function(container, options) {
  if (!container.length) { return; }

  options = options || {};

  this.callback = options.callback;
  this.container = container;
  this.selector = selector = options.selector || 'input';

  if (options.parent) {
    this.parent_selector = options.parent;
  }

  this.container.find(selector).click(_.bind(this.highlight, this));

  this.highlight();

  this.container.addClass('superlabels');
};

h.superlabels.prototype.parent_selector = function(element) {
  return element.parent();
};

h.superlabels.prototype.highlight = function() {
  var value = null,
      self = this;

  this.container.find(this.selector).each(function() {
    var $this = $(this),
        parent = self.parent_selector($this),
        checked = $this.prop('checked');

    parent.toggleClass('checked', checked);
    if (checked) {
      value = $this.prop('value');
    }
  });

  this.callback && this.callback(value);
};

if ($) {
  $.fn.superlabels = function(options) {
    $(this).each(function() {
      new h.superlabels($(this), options);
    });
  };
}
;
