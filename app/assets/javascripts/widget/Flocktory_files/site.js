$('#site').each(function() {

  var container = $(this);

  new h.DateFilter($('#date_filter'));

  // campaign list filter
  (function(){
    var campaigns_list = container.find('.campaigns_list');
  
    new h.tabs({
      'tabs': container.find('.campaigns_block .minitabs ins'),
      'callback': function (tab) {
        var filter = tab.data('filter');
  
        campaigns_list.toggleClass('show_active',  filter != 'inactive')
        campaigns_list.toggleClass('show_inactive', filter == 'inactive')
      }
    });

  })();

  // activity feed updates
  (function(){
    var activity_feed = container.find('.activities'),
        url = activity_feed.data('url'),

        timestamp = null,
        load_timeout = null,

        schedule_load = function () {
          timestamp = activity_feed.find('.item:first').data('timestamp');
          load_timeout = setTimeout(load, 20000);
        },


        load = function () {
          $.ajax({
            'url': url,
            'dataType': 'json',
            'data': {
              'since': timestamp
            },
            'success': function (data) {
              if (data['html']) { render(data['html']); };
              schedule_load();
            }
          });
        },

        render = function (html) {
          var div = $('<div/>', { 'html': html }).hide().prependTo(activity_feed);
          div.css({ 'marginTop': -div.outerHeight() }).animate({ 'marginTop': 0 }).show();

          activity_feed.find('.empty').fadeOut(function() { $(this).remove(); });
          activity_feed.find('.item').slice(100, 1000).fadeOut(function () {
            $(this).remove();
          });
        };

    schedule_load();
  })();
});

