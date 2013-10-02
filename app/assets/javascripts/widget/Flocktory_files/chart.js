h.Chart = function(options) {
  this.options = _.extend({}, this.options, options);

  _.bindAll(this, 'load_library', 'init');
  this.load_library();

  h.Chart.counter = 0;
};

h.Chart.prototype.options = {
  'enable_group_by': true
};

h.Chart.prototype.load_library = function() {
  if (typeof(google) === 'undefined') {
    setTimeout(this.load_library, 1000);

    return;
  }

  if (h.Chart._loaded) {
    this.init();
  } else {
    google.load('visualization', '1.0', { 'packages': ['corechart', 'controls'], 'language': h.current['locale'] });
    google.setOnLoadCallback(this.init);
  }
};

h.Chart.prototype.init = function() {
  h.Chart._loaded = true;

  this._id = (h.Chart.counter += 1);

  this.initialize();
};

h.Chart.prototype.enable_group_by = function(from, to) {
  var bys = ['day', 'week', 'month'],
      period = (to - from) / (1000 * 60 * 60 * 24); // days

  if (period < 90) {
    bys.pop(); // remove month

    if (period < 27) { return; } // day is the only option
  };

  if (!this.options['group_by']) {
    this.options['group_by'] =
      period >= 180 ? 'month' :
      period >= 90 ? 'week' : 'day';
  };

  var current = this.options['group_by'];

  var group_by = $('<div/>', { 'class': 'group_by'});

  var html = [
    '<div class="label">' + I18n.t('group_by.label') + '</div> '
  ];

  _.each(bys, function (by) {
    var checked = by === current ? ' checked="checked"' : '';

    html.push(
      '<label>',
        '<input type="radio" name="group_by" value="' + by + '"' + checked + '/>',
        I18n.t('group_by.' + by),
      '</label>'
    );
  });

  group_by.html(html.join(''));
  group_by.appendTo(this.options['container']);

  new h.superlabels(group_by, { 'callback': _.bind(this.set_group_by, this) });
};

h.Chart.prototype.set_group_by = function (group_by) {
  if (this.options['group_by'] === group_by) { return false; }

  this.options['group_by'] = group_by;

  if (this.timeline) {
    switch (this.options['group_by']) {
      case 'week':
        var min_range = 21 * 24 * 3600 * 1000; // 21 day
        break;
      case 'month':
        var min_range = 3 * 31 * 24 * 3600 * 1000; // 3 months
        break;
    }

    if (min_range) {
      var range = this.timeline.getState().range;

      if (range.start > (range.end - min_range)) {
        range.start = new Date(range.end - min_range);
        this.timeline.setState({range: range});
      }
    };
  };

  this.draw();
};

h.Chart.prototype.group_by = function(datatable, by, percent) {
  if (!google) { return datatable; }

  switch(by) {
    case 'week':
      var is_key_row = function (date) {
        var copy = new Date(date.getTime()),
            day  = copy.getDay();

        if (day !== 1) { copy.setHours(-24 * (day-1)) };

        return copy - date == 0;
      };
      break;
    case 'month':
      var is_key_row = function (date) {
        var copy = new Date(date.getTime());

        copy.setDate(1);

        return copy - date == 0;
      };
      break;
    default:
      return datatable;
  };

  var data = JSON.parse(datatable.toJSON()),
      rows = data['rows'];

  var i = 0, row, key_row, buffer = [];
  while (row = rows[i]) {
    var date = row['c'][0]['v'].replace(/Date\(([^)]+)\)/, '$1').split(', ');

    date[1] = parseInt(date[1]) + 1;
    date = new Date(date.slice(0, 3));

    row['c'][0]['v'] = date;

    if (!is_key_row(date) && key_row) {
      buffer.push(row['c']);
      rows.splice(i, 1);
    } else {

      if (key_row && buffer.length) {
        _.each(buffer, function (r) {
          _.each(r.slice(1, 9999), function (value, index) {
            index += 1;
            key_row['c'][index]['v'] =
              (key_row['c'][index]['v'] || 0) +
              (value['v'] || 0);
          });
        })

        if (percent) {
          _.each(key_row['c'].slice(1, 9999), function (value, index) {
            index += 1;
            key_row['c'][index]['v'] = key_row['c'][index]['v'] / buffer.length;
          });
        }
      }

      i += 1;
      key_row = row; buffer = [];
    }
  };

  return (new google.visualization.DataTable(data));
};

h.Chart.prototype.format_data_column = function (datatable) {
  for (var v, i=0, l=datatable.getNumberOfRows(); i<l; i++) {
    v = datatable.getValue(i, 0);

    switch(this.options['group_by']) {
      case 'month':
        v = I18n.l(v, 'mmmmm yyyy');
        break;
      case 'week':
        v = I18n.l(v, 'd mmm') + ' – ' + I18n.l(new Date(v.getTime() + 518400000), 'd mmm');
        break;
      default:
        v = I18n.l(v, 'd mmm');
    };

    datatable.setFormattedValue(i, 0, v);
  }
};

h.Chart.prototype.initialize = function () {};
