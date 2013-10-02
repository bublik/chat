I18n.set_locale(h.current['locale']);


// Zendesk
(function() {
  if (!h.current['account']) { return; }

  setTimeout(
    function () {
      head.js('//assets.zendesk.com/external/zenbox/v2.5/zenbox.js', '//assets.zendesk.com/external/zenbox/v2.5/zenbox.css', function () {
        if (typeof(Zenbox) !== "undefined") {
          Zenbox.init({
            dropboxID:   "20139651",
            url:         "https://flocktory.zendesk.com",
            tabID:       "Есть вопрос?",
            tabColor:    "#3E9536",
            tabPosition: "Left"
          });
        }
      })
    }
  , 100);
})();

$('*[data-toggle]').each(function() {
  new h.toggle($(this));
});

$('*[data-tip]').each(function() {
  new h.Tip($(this));
});

h.confirm = (new h.popup.confirm()).show;

$('.support_link').click(function (e) {
  if (Zenbox) {
    Zenbox.show();
    e.preventDefault();
  };
});

// UserVoice
// (function() {
//   if (!h.current['account']) { return; }
// 
//   window['uvOptions'] = {};
//   head.js(
//     ('https:' == document.location.protocol ? 'https' : 'http') + '://widget.uservoice.com/eYefl1M8lEwdNSZxHhz3DQ.js'
//   );
// })();
