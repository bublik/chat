$('#site_campaign_comparison').each(function () {
  var container = $(this);

  new h.DateFilter($('#date_filter'));

  var campaigns = container.find('.campaigns_list div.campaign');

  var comparison = new h.Chart.CampaignComparison({
    'container':     container.find('div.chart'),
    'data':          h.current.comparison_stats
  });

  var get_campaign_ids = function () {
    return _.map(campaigns.find('input:checked'), function (e) { return e.value-0; });
  };

  var campaign_labels = new h.superlabels(campaigns, {
    'callback': function () {
      comparison && comparison.set_campaigns(get_campaign_ids());
    }
  });

  new h.tabs({
    'tabs': container.find('.campaigns_block .minitabs ins'),
    'callback': function (tab) {
      var filter = tab.data('filter'),
          selector =
            filter == 'active' ? '.active_campaign' :
            filter == 'inactive' ? '.inactive_campaign' : '*';

      campaigns.
        hide().find('input').prop('checked', false).
        end().filter(selector).
        show().find('input').slice(0, 3).prop('checked', true);

      campaign_labels.highlight();
    }
  });
});
