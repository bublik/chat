$('#top_advocates').each(function () {
  var container = $(this);

  new h.DateFilter($('#date_filter'));

  container.find('.row').click(function () {
    $(this).parent().toggleClass('open');
  });
});
