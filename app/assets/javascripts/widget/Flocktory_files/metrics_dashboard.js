$('#metrics_dashboard').each(function () {
  var container = $(this),
      chart_container = container.find('.chart'),
      chart,

      legend = container.find('.legend'),

      get_active = function() {
        return _.map(legend.find('input'), function(input) {
          var input = $(input);
          if (input.prop('checked')) {
            return input.val();
          };
        });
      };

  new h.DateFilter($('#date_filter'));

  $('#kpi').click(function (e) {
    h.scroll_to($('#social_block'))
  });

  new h.superlabels(legend, {
    'callback': function() {
      chart && chart.set_active(get_active());
    },
    'parent': function(element) { return element.parents('dl'); }
  });

  chart = new h.Chart.Campaign({
    'container': chart_container,
    'data': h.current.stats['data'],
    'active': get_active()
  });

});
