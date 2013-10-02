h.Form = function(form) {
  _.bindAll(this, 'on_focus', 'on_blur');
 
  this.form = form;

  form.find('.input.infield label').inFieldLabels();

  this.handle_first_error();

  form.find('input, textarea, select').bind('focus', this.on_focus).bind('blur', this.on_blur);

  form.find('[data-input_tip]').each(function () { 
    new h.Tip(
      $(this).closest('div.input'),
      {
        'text': $(this).data('input_tip')
      }
    ); 
  });
};

h.Form.prototype.handle_first_error = function() {
  var first_error = this.form.find('div.field_with_errors:first');

  if (first_error.length) {
    h.scroll_to(first_error, {
      'offset': -20,
      'callback': function () {
        first_error.find('input:text').focus();
      }
    })
  }
};

h.Form.prototype.on_focus = function (e) {
  var input = $(e.target).parents('div.tip_container');
  
  input.addClass('show_tip');
};

h.Form.prototype.on_blur = function (e) {
  var input = $(e.target).parents('div.tip_container');
  
  input.removeClass('show_tip');
};
