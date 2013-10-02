h.popup.confirm = function() {
    _.bindAll(this, 'action', 'show');

    h.popup.call(this,
        $('<div/>'),
        { 'className': 'confirm_popup' }
    );

    this.buttons = $('<div/>', { 'class': 'buttons' }).append(
        this.yes_button = $('<a/>', { 'href': '#', 'class': 'yes button' }).click(this.action),
        this.no_button = $('<a/>', { 'href': '#', 'class': 'no button' }).click(this.hide)
    );
};

h.inherits(h.popup.confirm, h.popup);

h.popup.confirm.prototype.action = function() {
    this.hide();
    this._action && this._action();
};

h.popup.confirm.prototype.create = function() {
    h.popup.prototype.create.call(this);

    this.buttons.appendTo(this.popup);
};

h.popup.confirm.prototype.show = function(text, action, options) {
    options = options || {};

    this._action = action;
    this.content.html(text);

    this.yes_button.html(options['yes'] || I18n.t('yes'));
    this.no_button.html(options['no'] || I18n.t('no'));

    h.popup.prototype.show.apply(this);

    this.buttons.find('.button:first').focus();
};

h.popup.confirm.prototype.on_keypress = function(e) {
    h.popup.prototype.on_keypress.call(this, e);

    if (e.keyCode == this.KEYCODES.ENTER) {
        this.action();
    }
};
