h.RadioWatch = function(container, options) {
  if (options && options.call) {
    options = { 'callback': options };
  };

  this.container = container;
  this.options = options || {};

  this._callbacks = [];

  this.options['callback'] && this._callbacks.push(this.options['callback']);

  this.radios = this.container.find('input:radio');

  _.bindAll(this, 'on_click');
  this.radios.click(this.on_click);

  this.on_click();
};

h.RadioWatch.prototype.on_click = function() {
  var value = this.get_value();

  for(var i = 0, l = this._callbacks.length; i < l; i++) {
    this._callbacks[i](value);
  };
};

h.RadioWatch.prototype.get_value = function() {
  return this.radios.filter(':checked').val();
};

h.RadioWatch.prototype.bind = function(f) {
  this._callbacks.push(f);
  f(this.get_value());
};

h.RadioWatch.prototype.select = function(value) {
  if (typeof(value) == 'number') {
    this.radios.eq(value).trigger('click');
    this.on_click();
  }
};

h.RadioWatch.prototype.unbind = function(f) {
  for(var i = 0, l = this._callbacks.length; i < l; i++) {
    if (f === this._callbacks[i]) { 
      this._callbacks.splice(i, 1);
      return;
    }
  };
};
