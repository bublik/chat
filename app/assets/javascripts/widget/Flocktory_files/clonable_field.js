h.ClonableField = function (options) {
  this.options = _.extend({}, this.options, options || {});
  this.init();
};

h.ClonableField.prototype.options = {
  'field_selector': '.input',
  'add_text':       '+',
  'remove_text':    '-'
};

h.ClonableField.prototype.init = function () {
  this.container = this.options['container'];

  _.bindAll(this, 'on_add', 'on_remove', 'check_fields');

  if (!this.container.length) { return; }

  this.add_button = 
    $('<ins/>', {
      'html':   this.options['add_text'],
      'class': 'clonableField_add'
    }).
      appendTo(this.container);

  this.container.find(this.options['field_selector']).append(
    $('<ins/', {
      'html':   this.options['remove_text'],
      'class': 'clonableField_remove'
    })
  );

  this.turn_events('on');

  this.check_fields();

  this.container.addClass('clonableFields_on');
};

h.ClonableField.prototype.check_fields = function () {
  this.container.toggleClass('clonableField_several',
    this.container.find(this.options['field_selector']).length > 1
  );
};

h.ClonableField.prototype.turn_events = function (action) {
  this.add_button[action]('click', this.on_add);
  this.container[action]('click', '.clonableField_remove', this.on_remove);
};

h.ClonableField.prototype.on_remove = function () {
  var element = this.closest(this.options['field_selector']);

  this.options['before_remove'] &&  this.options['before_remove'](element);

  element.remove();
};

h.ClonableField.prototype.on_add = function () {
  var element = this.container.find(this.options['field_selector'] + ':last');

  var new_element = element.clone();

  new_element.find('input,textarea,select').each(function () {
    this.name = this.name.replace(/attributes\]\[(\d+)\]\[/, function (a,b,c) {
      var n = parseInt(b);

      return isNaN(n) ? a : "attributes][" + (n + 1) + "][";
    });
  });

  new_element.insertAfter(element);

  this.options['after_add'] &&  this.options['after_add'](new_element);

  this.check_fields();
};

h.ClonableField.prototype.destroy = function () {
  this.container.removeClass('clonableFields_on');
  this.turn_events('off');
  this.container.find('.clonableField_remove').remove();
  this.add_button.remove();
};
