h.autogrow = function(textarea, options) {
    this.textarea = textarea = $(textarea);
    this.options = options = options || {};

    this.gap = options['gap'] || 0;

    if (!textarea.length) { return; }

    this.minHeight = textarea.height();
    this.shadow = $('<div></div>');
    this.copy();
    this.shadow.appendTo(document.body);

    this.update = _.bind(this.update, this);

    textarea.change(this.update).keyup(this.update).keydown(this.update);

    this.update();
};

h.autogrow.prototype.copy = function() {
    this.shadow.css({
        position: 'absolute',
        top: -10000,
        left: -10000,
        width: this.textarea.width(),
        fontSize: this.textarea.css('fontSize'),
        fontFamily: this.textarea.css('fontFamily'),
        fontWeight: this.textarea.css('fontWeight'),
        lineHeight: this.textarea.css('lineHeight'),
        resize: 'none'
    });
};

h.autogrow.prototype.update = function() {
    var val = this.textarea[0].value.replace(/</g, '&lt;')
                        .replace(/>/g, '&gt;')
                        .replace(/&/g, '&amp;')
                        .replace(/\n$/g, '<br/>&nbsp;')
                        .replace(/\n/g, '<br/>');

    this.shadow.html(val);
    this.textarea.css('height', Math.max(this.shadow.height() + this.gap, this.minHeight));
};
