h.tabs = function(options) {
  this.options = options || {};

  this.init();
};

h.tabs.prototype.init = function() {
  if (!this.options.tabs.length) { return; }

  this.tabs = this.options.tabs;
  this.blocks = this.options.blocks;

  _.bindAll(this, 'on_tab_click');

  this.tabs.bind('click', this.on_tab_click);
};

h.tabs.prototype.on_tab_click = function(e) {
  e && e.preventDefault && e.preventDefault();

  var a = $(e.target).closest('a,ins'),
      n = a.prevAll().length;

  if (a.hasClass('active') || this.before_callback_stopped()) {
    return;
  }

  this.open(n);
};

h.tabs.prototype.before_callback_stopped = function() {
  return this.options['before_change'] && this.options['before_change']() == false;
};

h.tabs.prototype.open = function(n) {
  var block,
      tab = this.tabs.removeClass('active').eq(n).addClass('active');

  if (this.blocks && this.blocks.length) {
    this.blocks.hide().removeClass('active');

    block =
      (this.options['select_block'] && this.options['select_block'](tab)) ||
      this.blocks.eq(n);

    block.show().addClass('active');
  };

  this.options.callback && this.options.callback(tab, block);
};

h.tabs.prototype.open_next = function() {
  var next_tab = this.tabs.filter('.active').next(),
      next_n = next_tab && next_tab.prevAll().length;

  if (next_n && !this.before_callback_stopped()) { this.open(next_n); }
};
