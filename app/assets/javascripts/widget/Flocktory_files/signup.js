$('#login.signup').each(function () {
  var container = $(this);

  var tariff_select = container.find('#account_tariff');

  tariff_select.change(function () {
    if (tariff_select.val() == 'enterprise') {
      var form = tariff_select.closest('form');

      form.
        append($('<input/>', { 'type': 'hidden', 'name': 'do_not_save', 'value': 1 })).
        submit();
    };
  });
});
