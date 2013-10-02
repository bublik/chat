$('form#ab_group').each(function() {
  var form = $(this);

  form.find('.collection_fields').each(function () {
    new h.ClonableField({
      'container':      $(this),
      'field_selector': '.collection_element',
      'add_text':       I18n.t('abgroup_form.add'),
      'remove_text':    I18n.t('abgroup_form.remove')
    })
  });
});
