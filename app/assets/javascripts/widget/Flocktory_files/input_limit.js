h.inputLimit = function(element, options) {
  this.options = _.extend({}, this.options, options);
  this.element = element;

  this.init();
};

h.inputLimit.prototype.options = {
  'limit': 140,
  'prevent': true,
  'hideInactive': true
};

h.inputLimit.prototype.init = function() {
  _.bindAll(this, 'update_counter', 'show_counter', 'hide_counter');

  this.counter = this.options.counter || this.create_counter();

  if (this.options.hideInactive) {
    this.counter.hide();

    this.element.
      focus(this.show_counter).
      blur(this.hide_counter);
  }

  this.element.bind('keydown keyup keypress paste', this.update_counter);
  this._element = this.element[0];

  this.update_counter();
};

h.inputLimit.prototype.create_counter = function() {
  return $('<div/>', {
    'class': 'counter'
  }).insertAfter(this.element);
};

h.inputLimit.prototype.update_counter = function(e) {
  var value =
    this.options.limit - this._element.value.length;

  if (this.options.prevent && value < 0) {
    this._element.value = this._element.value.substr(0, this.options.limit);

    value = 0;
  }

  this.counter.text(value);
  this.counter.toggleClass('limited', !value);
};

h.inputLimit.prototype.show_counter = function() {
  this.counter.show();
};

h.inputLimit.prototype.hide_counter = function() {
  this.counter.hide();
};
