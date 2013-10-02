h.toggle = function(element) {

  var target = $(element.data('toggle')),
      tag = element[0].tagName.toLowerCase(),
      type = element.attr('type');

  if (tag == 'input' && type == 'checkbox') {
    element.click(_.bind(this.checkbox_click, element, target));
  } else {
    element.click(_.bind(this.click, element, target));
  }

};

h.toggle.prototype.click = function(target) {
  target.toggle();
};

h.toggle.prototype.checkbox_click = function(target) {
  target.css({
    'display': this.prop('checked') ? '' : 'none'
  });
  // target.toggle(this.prop('checked'));
};
