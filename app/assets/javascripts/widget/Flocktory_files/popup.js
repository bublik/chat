h.popup = function(content, options) {
  this.options = _.extend({}, this.OPTIONS, options);
  this.content = content;

  this.init();
};

h.popup.prototype.KEYCODES = {
  ENTER: 13,
  ESC: 27,
  TAB: 9
};

h.popup.prototype.init = function() {
  _.bindAll(this, 'hide', 'on_keypress', 'on_click');
};

h.popup.prototype.create = function() {
  if (!this.overlay) {
    this.overlay = $('<div/>', { 'class': 'popup_overlay' }).
      appendTo(document.body);
  }

  if (!this.popup) {
    this.popup = $('<div/>', { 'class': 'popup' }).
      append(this.content).
      appendTo(this.overlay);

    if (this.options.className) {
      this.popup.addClass(this.options.className);
    }
  }
};

h.popup.prototype.show = function() {
  if (!this.popup) {
    this.create();
  }

  this.bind_events();

  $(document.body).css({'overflow': 'hidden'});

  this.overlay.show();
  this.popup.show();
};

h.popup.prototype.hide = function() {
  this.popup.hide();
  this.overlay.hide();

  this.unbind_events();

  $(document.body).css({'overflow': ''});
};

h.popup.prototype.bind_events = function() {
  this.overlay.bind('click', this.on_click);
  $(document).bind('keyup', this.on_keypress);
};

h.popup.prototype.unbind_events = function() {
  this.overlay.unbind('click', this.on_click);
  $(document).unbind('keyup', this.on_keypress);
};

h.popup.prototype.on_click = function(e) {
  var t = $(e.target);

  if (t.closest(this.popup).length == 0) {
    this.hide();
  }
};

h.popup.prototype.on_keypress = function(e) {
  if (e.keyCode == this.KEYCODES.ESC) { this.hide(); }
};
