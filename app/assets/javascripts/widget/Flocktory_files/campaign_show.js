$('#campaign_show').each(function() {

  var container = $(this);

  $('#stop_button').click(function(e) {
    e.preventDefault();

    h.confirm(
        I18n.t('campaign.stop_popup.text'),
        function() {
            $.rails.handleMethod(
                $('#stop_button')
            );
        },
        {
            'yes': I18n.t('campaign.stop_popup.yes'),
            'no': I18n.t('campaign.stop_popup.no')
        }
    );

    return false;
  });

});
