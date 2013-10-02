h.CustomizeColors = function(form, css) {
  if (!form.length) { return; }

  this.form = form;
  this.css = css;

  this.init();
};

h.CustomizeColors.prototype.init = function() {
  _.bindAll(this, 'color_changed', 'form_changed', 'on_submit');

  this.inputs = this.form.find('input:text');
  this.button = this.form.find('button');
  this.inner_button = this.button.find('div');

  this.sensitive_form = new h.sensitiveForm(this.form, {
    'callback': this.form_changed
  });

  this.form_changed(false);
  this.form.bind('submit', this.on_submit);

  this.inputs.miniColors({
    'change': this.color_changed
  });
};

h.CustomizeColors.prototype.color_changed = function() {
  var data = {};

  this.inputs.each(function() {
    var $this = $(this);

    data[
      $this.prop('name').match(/\[(.+)?\]/)[1]
    ] = $this.prop('value');
  });

  _.each(this.calculated_colors, function(calc, key) {
    data[key] = h.colors.lighten(
      data[calc[0]],
      calc[1]
    );
  });

  this.css.html(
    this.css_template({'data': data})
  );
};

h.CustomizeColors.prototype.form_changed = function(changed) {
  this.inner_button.toggleClass('disabled', !changed);
  this.button.prop('disabled', !changed);
};

h.CustomizeColors.prototype.on_submit = function(e) {
  e.preventDefault();

  this.save();
};

h.CustomizeColors.prototype.save = function() {
  $.ajax({
    'url': this.form.prop('action') + '.json',
    'type': 'POST',
    'data': this.form.serialize()
  });

  this.sensitive_form.update_hash();
  this.sensitive_form.check();
};

h.CustomizeColors.prototype.calculated_colors = {
  'emphasis1_color' : ['color1', 0],
  'icons_color' : ['color1', 6],
  'emphasis2_color' : ['color2', 0],
  'form_bg_color' : ['color1', 0],
  'buttons_color' : ['color2', -15],
  'notebg_color' : ['color2', 25],
  'notetext_color' : ['color2', -20],
  'couponbg_color' : ['color3', 33],
  'coupontext_color' : ['color3', 0]
};

h.CustomizeColors.prototype.css_template = _.template('\
  #customize .popup_example .header, \
	  #customize .popup_example .header textarea,\
	  \
	  #customize .popup_example .shares h4, \
	  #customize .popup_example .shares h4 textarea,\
	  \
	  #customize .popup_example #copy #copy_link,\
	  #customize .popup_example .footer .agreement .link \
	  \
	    { color: <%= data.emphasis1_color %>; }\
	\
	  #customize .popup_example .slide_form,\
	  #customize .popup_example .slide_form .arrow\
	\
	    { background-color: <%= data.form_bg_color %>; }\
	\
	  #customize .popup_example .button\
	    { background-color: <%= data.buttons_color %>; }\
	\
	  #customize .popup_example .redemption\
	    { background: <%= data.notebg_color %>; }\
	\
	  #customize .popup_example .redemption h4,\
	  #customize .popup_example .redemption h4 textarea\
	    { color: <%= data.notetext_color %>; }\
	\
	  #customize .popup_example .steps .step .icon\
	    { background: <%= data.icons_color %>; }\
	  \
	  #customize .popup_example .steps .step .icon .b\
	    { background: <%= data.emphasis2_color %>; }\
	  \
	  #customize .popup_example .steps .step .icon .o\
	    { background: <%= data.icons_color %>; }\
	\
	\
	  #customize .landing_page_example #box .header, \
	  #customize .landing_page_example #box .header textarea,\
	  \
	  #customize .landing_page_example #box .time #counter,\
	  #customize .landing_page_example #box .footer .agreement .link \
	  \
	    { color: <%= data.emphasis1_color %>; }\
	\
	  #customize .landing_page_example #box .slide_form,\
	  #customize .landing_page_example #box .slide_form .arrow\
	\
	    { background-color: <%= data.form_bg_color %>; }\
	\
	  #customize .landing_page_example #box .coupon_block \
	    { background: <%= data.notebg_color %>; }\
	  \
	  #customize .landing_page_example #box .coupon_block,\
	  #customize .landing_page_example #box .coupon_block textarea\
	    { color: <%= data.notetext_color %>; }\
	  \
	  #customize .landing_page_example #box .coupon_block .coupon\
	    { \
	      color: <%= data.coupontext_color %>; \
	      border-color: <%= data.coupontext_color %>; \
	      background: <%= data.couponbg_color %>; \
	    }\
	\
	  #customize .landing_page_example #box .button\
	    { background-color: <%= data.buttons_color %>; }\
	\
	  #customize .landing_page_example #box .steps .step .icon\
	    { background: <%= data.icons_color %>; }\
	  \
	  #customize .landing_page_example #box .steps .step .icon .b\
	    { background: <%= data.emphasis2_color %>; }\
	  \
	  #customize .landing_page_example #box .steps .step .icon .o\
	    { background: <%= data.icons_color %>; }\
\
\
    #customize .email_example .emphasis1_color { color: <%= data.emphasis1_color %>; }\
    #customize .email_example .emphasis2_color { color: <%= data.emphasis2_color %>; }\
    #customize .email_example .coupon_colors { color: <%= data.coupontext_color %>; background: <%= data.couponbg_color %>; }\
    \
    #customize .email_example .notetext_color { color: <%= data.notetext_color %>; }\
    #customize .email_example .notebg_color { background: <%= data.notebg_color %>; }\
    \
    #customize .email_example .emphasis1_border { border-color: <%= data.emphasis1_color %> !important; }\
\
    #customize .email_example .footer a { color: <%= data.emphasis1_color %>; }\
  ',
  null, {'variable': 'data'}
);
