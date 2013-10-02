h.Chart.CampaignComparison = function (options) {
  h.Chart.apply(this, arguments);
};

h.inherits(h.Chart.CampaignComparison, h.Chart);

h.Chart.CampaignComparison.prototype.initialize = function () {
  if (!this.options['container'].length) { return; }
  this.container = this.options['container'];

  _.bindAll(this, 'set_metric', 'set_campaigns');

  this.metric_filter = 
    this.container.parent().find('.filters .metric').bind('change', this.set_metric);

  this.set_metric();

  this.create();
};

h.Chart.CampaignComparison.prototype.create = function () {
  var container = this.container,
      graph_id    = "chart_graph_" + this._id,
      timeline_id = "timeline_graph_" + this._id,

      date_from   = new Date(this.options['data']['from']),
      date_to     = new Date(this.options['data']['to']);

  this.show_timeline = false && (date_to - date_from) > (7 * 24*60*60*1000);

  this.chart_options = _.extend({}, this.CHART_OPTIONS);

  if (-date_to == -date_from) {
    this.chart_options['pointSize'] = 7;
  };

  container.find('.graph').prop('id', graph_id);

  this.enable_group_by(date_from, date_to);

  this.graph = new google.visualization.ChartWrapper({ 
    'chartType': 'LineChart',
    'containerId': graph_id,
    'options': this.chart_options
  });

  if (this.show_timeline) {
    container.find('.timeline').prop('id', timeline_id);

    this.timeline = new google.visualization.ControlWrapper({
      'controlType': 'ChartRangeFilter',
      'containerId': timeline_id,
      'options': this.TIMELINE_OPTIONS,
      'state': { 'range': { 'start': new Date(date_to - 14*24*60*60*1000), 'end': date_to } }
    });

    this.dashboard = new google.visualization.Dashboard(container[0]);

    this.dashboard.bind(this.timeline, this.graph);
  };

  this.draw();
};

h.Chart.CampaignComparison.prototype.draw = function () {
  if (!this._campaigns) { return; }

  this._drawn = true;

  if (this.show_timeline) {
    this.dashboard.draw(this.getData());
  } else {
    this.graph.setDataTable(this.getData());
    this.graph.draw();
  };
};

h.Chart.CampaignComparison.prototype.getData = function () {
  var self = this,
      metric = this._metric[0],

      campaign_ids = this._campaigns,

      colors = [],
      percent = this._metric[1] == 'percent',
      datatable = new google.visualization.DataTable(),
      data = this.options['data'],
      from = 0, to = 0,
      table = [];

  datatable.addColumn('date', 'Дата');

  _.each(campaign_ids, function (campaign_id) {
    var d = data['data'][campaign_id];

    colors.push({ 'color': d['color'] });
    datatable.addColumn('number', d['title']);
  });

  if (colors.length == 0) {
    datatable.addColumn('number', 'Value');
    datatable.addRows([[new Date(),0]]);

    return datatable;
  } else {
    for(var day = data['from']; day <= data['to']; ) {
      var date = new Date(day),
          daykey = I18n.localize(new Date(day), 'yyyy-mm-dd');

      table.push(
        ([date]).concat(
          _.map(campaign_ids, function(campaign_id) {
            var h = data['data'][campaign_id]['metrics'][daykey]

            return (h && h[metric]) || 0;
          })
        )
      );

      day += 24*60*60*1000;
    }
  };

  datatable.addRows(table);

  datatable = this.group_by(datatable, this.options['group_by'], percent)
  this.format_data_column(datatable)

  if (percent) {
    var percent_formatter = new google.visualization.NumberFormat({pattern: '#,##%'});

    for(var i=1, l=campaign_ids.length; i<=l; i++) {
      percent_formatter.format(datatable, i);
    };
  };

  this.graph.setOption('vAxis.format', percent ? '#,##%' : null);
  this.graph.setOption('series', colors);
  this.show_timeline && this.timeline.setOption('ui.chartOptions.series', colors);

  return datatable;
};

h.Chart.CampaignComparison.prototype.parseDate = function (s) {
  var s = s.split('-');

  return (new Date(s[0], s[1] - 1, s[2]));
};

h.Chart.CampaignComparison.prototype.set_campaigns = function (campaigns) {
  this._campaigns = 
    (
      this.options['data']['data']['all'] ? ['all'] : []
    ).concat(
      campaigns || []
    );

  this.graph && this.draw();
};

h.Chart.CampaignComparison.prototype.set_metric = function (metric) {
  this._metric = JSON.parse(this.metric_filter.prop('value'));

  $.cookie('cc_metric', this._metric, { expires: 365 });

  if (this._drawn) { this.draw(); }
};

h.Chart.CampaignComparison.prototype.CHART_OPTIONS = {
  // backgroundColor: '#f0f0f0',
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
  hAxis: { 'baselineColor': '#eee' },
  vAxis: { 'baselineColor': '#eee', 'gridlines': { color: '#eee' } }
};

h.Chart.CampaignComparison.prototype.TIMELINE_OPTIONS = {
  filterColumnIndex: 0,
  ui: {
    chartType: 'LineChart',
    chartOptions: {
      // backgroundColor: '#f0f0f0',
      chartArea: {
        left: '10%',
        width: '88%'
      },
      lineWidth: 1,
      hAxis: { 'textPosition': 'none', 'baselineColor': '#fff'},
      vAxis: { 'baselineColor': '#fff'}
    },
    minRangeSize: 7 * 24 * 60 * 60 * 1000
  }
};
