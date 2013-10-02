h.DateFilter = function() {
  this.init.apply(this, arguments);
};

h.DateFilter.prototype.init = function(container, options) {
  _.bindAll(this, 'preselect_click');

  this.container = container;

  new h.Calendar(container.find('.time_from, .time_to'));

  this.container.find('.preselect').delegate('ins', 'click', this.preselect_click);
};

h.DateFilter.prototype.preselect_click = function(e) {
  var value = $(e.target).data('value');

  if (value) {
    if (value.push) {
      var from = value[0].split('-'), to = value[1].split('-');

      from = new Date(from[0], from[1] - 1, from[2]);
      to = new Date(to[0], to[1] - 1, to[2]);

    } else {
      var to = new Date(), from = new Date();

      switch (value) {
        case 'month':
          from.setMonth(from.getMonth() - 1);
          break;
        case 'quarter':
          from.setMonth(from.getMonth() - 3);
          break;
        case 'year':
          from.setYear(from.getFullYear() - 1);
          break;
        default:
          from.setDate(from.getDate() - 14);
      };
    }

    this.container.find('.time_from').prop('value', this.format_date(from));
    this.container.find('.time_to').prop('value', this.format_date(to));

    this.container.submit();
  };
};

h.DateFilter.prototype.format_date = function(d) {
  return I18n.localize(d, 'dd.mm.yy');
};
