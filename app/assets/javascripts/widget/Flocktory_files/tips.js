h.Tip = function() { this.init.apply(this, arguments); }

h.Tip.prototype.init = function (element, options) {
  this.element = element;
  this.options = options || {};
  this.options['offset'] = this.options['offset'] || 15;

  _.bindAll(this, 'show', 'hide', 'pin', 'unpin');

  if (!this.element.length) { return; }

  this.element.data('_tip', this);

  this.enable();
};

h.Tip.prototype.enable = function () {
  if (this._enabled) { return; }
  this._enabled = true;

  this.element.
    bind({
      'mouseenter.tip': this.show,
      'mouseleave.tip':  this.hide
    }).
    find('input,textarea,select').
      bind({
        'focus.tip': this.pin,
        'blur.tip':  this.unpin
      });
};

h.Tip.prototype.disable = function () {
  if (!this._enabled) { return; }
  this._enabled = false;

  this.element.
    unbind('.tip').
    find('input,textarea,select').
      unbind('.tip');

  this.container && this.container.remove();
};

h.Tip.prototype.create = function () {
  this.text = this.text || this.options['text'] || this.element.data('tip');

  this.container = $('<div/>', {
    'class': 'hover_tip',
    'html': this.text
  }).appendTo(document.body);
};

h.Tip.prototype.position = function () {
  var pos = this.element.offset();

  this.container && this.container.css({
    'top':  pos['top'] + this.element.outerHeight() + this.options['offset'],
    'left': pos['left']
  });
};

h.Tip.prototype.show = function () {
  if (!this.container) { this.create(); }

  this.position();
  this.container.stop(true, true).appendTo(document.body).fadeIn(150);
};

h.Tip.prototype.hide = function () {
  this.container && !this._pinned && this.container.stop(true, true).fadeOut(150);
};

h.Tip.prototype.pin = function () {
  this._pinned = true;
  this.show();
};

h.Tip.prototype.unpin = function () {
  this._pinned = false;
  this.hide();
};

h.Tip.prototype.set_text = function (text) {
  this.text = text;
  this.container && this.container.html(text);
};
