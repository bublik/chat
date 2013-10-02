h.sensitiveForm = function(form, options) {
    this.form = form;
    this.options = options || {};

    this.init();
};

h.sensitiveForm.prototype.init = function() {
    this.update_hash();
    this._changed = false;

    this.check = _.bind(this.check, this);

    this.form.bind('change blur', this.check);

    this.check();
};

h.sensitiveForm.prototype.update_hash = function() {
    this._initial = this.serialize();
    this.check();
};

h.sensitiveForm.prototype.check = function() {
    var changed = this.serialize() != this._initial;

    if (changed != this._changed) {
        this._changed = changed;

        this.options['callback'] &&
            this.options['callback'](changed);
    }
};

h.sensitiveForm.prototype.serialize = function() {
    return this.form.serialize();
};
