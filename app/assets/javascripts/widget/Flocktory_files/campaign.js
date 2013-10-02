h.Chart.Campaign = function (options) {
  h.Chart.apply(this, arguments);
};

h.inherits(h.Chart.Campaign, h.Chart);

h.Chart.Campaign.prototype.METRICS = {
  'precheckout_click': {
    'color': '#aaa'
  },
  'purchase': {
    'color': '#DF151A'
  },
  'offer': {
    'color': '#FD8603'
  },
  'share': {
    'color': '#c00'
  },
  'landing': {
    'color': '#00c'
  },
  'lead': {
    'color': '#0aa'
  },
  'new_friend': {
    'color': '#eac700'
  },
  'new_order': {
    'color': '#00C135'
  }
};

h.Chart.Campaign.prototype.CHART_OPTIONS = {
  chartArea: {
    left: '10%',
    top: '2%',
    height: '80%',
    width: '88%'
  },
  focusTarget: 'category',
  areaOpacity: 1,
  lineWidth: 2,
  pointSize: 0,
  legend: { 'position': 'none' },
  hAxis: { 'baselineColor': '#ddd' },
  vAxis: { 'baselineColor': '#ddd', 'gridlines': { color: '#ddd' } }
};

h.Chart.Campaign.prototype.TIMELINE_OPTIONS = {
  filterColumnIndex: 0,
  ui: {
    chartType: 'LineChart',
    chartOptions: {
      chartArea: {
        left: '10%',
        width: '88%'
      },
      lineWidth: 1,
      hAxis: { 'textPosition': 'none', 'baselineColor': '#fff'},
      vAxis: { 'baselineColor': '#fff'},
      series: [ { 'color': h.Chart.Campaign.prototype.METRICS['offer']['color'] } ]
    },
    chartView: { 'columns': [0, 2] },
    minRangeSize: 7 * 24 * 60 * 60 * 1000
  }
};

h.Chart.Campaign.prototype.initialize = function () {
  if (!this.options['container'].length) { return; }

  var container = this.options['container'],
      graph_id    = "chart_graph_" + this._id,
      timeline_id = "timeline_graph_" + this._id,

      dates       = _.keys(this.options['data'])

      date_from   = dates[0].split('-'),
      date_to     = dates[dates.length-1].split('-');

  date_from = new Date(date_from[0], date_from[1] - 1, date_from[2]);
  date_to = new Date(date_to[0], date_to[1] - 1, date_to[2]);

  this.enable_group_by(date_from, date_to);

  this.show_timeline = (date_to - date_from) > (7 * 24*60*60*1000);

  container.find('.graph').prop('id', graph_id);

  this.chart_options = _.extend({}, this.CHART_OPTIONS);

  if (-date_to == -date_from) {
    this.chart_options['pointSize'] = 7;
  };

  this.graph = new google.visualization.ChartWrapper({
    'chartType': 'LineChart',
    'containerId': graph_id,
    'options': this.chart_options,
    'view': [0,7]
  });

  if (this.show_timeline) {
    container.find('.timeline').prop('id', timeline_id);

    this.timeline = new google.visualization.ControlWrapper({
      'controlType': 'ChartRangeFilter',
      'containerId': timeline_id,
      'options': this.TIMELINE_OPTIONS,
      'state': { 'range': { 'start': date_from, 'end': date_to } }
    });

    this.dashboard = new google.visualization.Dashboard(container[0]);

    this.dashboard.bind(this.timeline, this.graph);
  };

  this.set_active();

  this.draw();
};

h.Chart.Campaign.prototype.draw = function () {
  if (this.show_timeline) {
    this.dashboard.draw(this.getData());
  } else {
    this.graph.setDataTable(this.getData());
    this.graph.draw();
  };
};

h.Chart.Campaign.prototype.getData = function () {
  var datatable = new google.visualization.DataTable(),
      self = this;

  var data =
    _.map(this.options['data'], function (values, date) {
      var d = date.split('-'),
          r = [];

      r.push(new Date(d[0], d[1] - 1, d[2]));

      _.each(self.METRICS, function (value, key) {
        r.push(values[key] || 0);
      });

      return r;
    });

  datatable.addColumn('date', 'Дата');
  _.each(this.METRICS, function (value, key) {
    datatable.addColumn('number', I18n.t('campaign.metric.' + key));
  });

  datatable.addRows(data);

  datatable = this.group_by(datatable, this.options['group_by'])

  this.format_data_column(datatable)

  return datatable;
};

h.Chart.Campaign.prototype.set_active = function(active) {
  if (active) {
    this.options['active'] = active;

    $.cookie('c_metrics', active.join(','), { expires: 365 });
  };

  var self = this,
      show_columns = [],
      series = [];

  _.each(this.options['active'], function (metric) {
    if (metric) {
      series.push({ 'color': self.METRICS[metric] });
      show_columns.push(_.keys(self.METRICS).indexOf(metric) + 1)
    }
  });

  this.graph.setView({
    'columns': ([
      {
        'calc': function(dataTable, rowIndex) {
          return dataTable.getFormattedValue(rowIndex, 0);
        },
        'type': 'string'
      }
    ]).concat(show_columns)
  });
  this.graph.setOption('series', series);

  if (this.timeline) {
    this.timeline.setOption('ui.chartView', { 'columns': ([0]).concat(show_columns) });
    this.timeline.setOption('ui.chartOptions.series', series);
  }

  this.draw();
};
