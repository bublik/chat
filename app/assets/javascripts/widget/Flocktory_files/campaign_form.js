$('form#campaign').each(function() {
    var form = $(this);

    var coupon = $('#coupon');

    var 
      publisher_cashout_method  = new h.RadioWatch($('#publisher_cashout_method')),
      publisher_coupon_type     = new h.RadioWatch($('#publisher_coupon_type')),
      publisher_reward_type     = new h.RadioWatch($('#publisher_reward_type')),
      friend_cashout_method     = new h.RadioWatch($('#friend_cashout_method')),
      friend_coupon_type        = new h.RadioWatch($('#friend_coupon_type')),
      friend_reward_type        = new h.RadioWatch($('#friend_reward_type'));

    // Custom tips
    
    publisher_coupon_type_tip = new h.Tip(publisher_coupon_type.container, {
      'text': publisher_coupon_type.container.data('tip_options')
    });


    (function() {
      var publisher_coupon_percent = $('#publisher_coupon_type label.radio').eq(1),
          publisher_coupon_value   = $('#publisher_coupon_value'),
          publisher_reward_value   = $('#publisher_reward_value');

      publisher_cashout_method.bind(function(value) {
        publisher_coupon_percent.toggle(value == 'store_coupon');

        publisher_coupon_type_tip[value == 'store_coupon' ? 'enable' : 'disable']();

        if (value != 'store_coupon') {
          $('#campaign_publisher_coupon_type_currency').prop('checked', true).trigger('click');
        }
      });

      publisher_coupon_type.bind(function(value) {
        publisher_reward_type.container.
          add(publisher_reward_value).
          toggle(value != 'percent');

        publisher_coupon_value.toggle(value == 'percent');
      });

      var publisher_reward_suffix = $('#publisher_reward_value .suffix'),
          publisher_reward_value_tip = new h.Tip(publisher_reward_value),
          publisher_reward_value_tip_options = publisher_reward_value.data('tip_options');

      publisher_reward_type.bind(function(value) {
        publisher_reward_value_tip.set_text(publisher_reward_value_tip_options[value]);
        publisher_reward_suffix[0].className = 'suffix ' + value;
      });

      var friend_coupon = $('#friend_coupon');

      friend_cashout_method.bind(function(value) {
        friend_coupon.toggle(value == 'store_coupon');
      });

      var friend_reward_suffix = $('#friend_reward_value .suffix'),
          friend_reward_value = $('#friend_reward_value'),
          friend_reward_value_tip = new h.Tip(friend_reward_value),
          friend_reward_value_options = friend_reward_value.data('tip_options');

      friend_reward_type.bind(function (value) {
        friend_reward_value_tip.set_text(
          friend_reward_value_options[value]
        );

        friend_reward_suffix[0].className = 'suffix ' + value;
      });
    })();

    var publisher_reward_keyup;
    $('input.publisher_reward_input').
      focus(function() {
        var $this = $(this),
            target = $('input.friend_reward_input');

        if (
          $this.val() == target.val() &&
          $this.closest('li')[0].className == target.closest('li')[0].className
        ) {
          publisher_reward_keyup = function() {
            target[0].value = $this[0].value;
          };

          $this.bind('keyup', publisher_reward_keyup);
        }
      }).
      blur(function() {
        $(this).unbind('keyup', publisher_reward_keyup);
      });


    $('#campaign_coupon_in_url').superlabels({
      'callback': function(value) {

        $('#friend_coupon').toggleClass(
          'in_url',
          value == 'true'
        );
      }
    });

    var url_for_coupon = $('#url_for_coupon');
    $('#campaign_url').bind('change keyup paste', function() {
      var value = $(this).prop('value');

      if (value) {
        if (~value.indexOf('?')) {
          if (!value.match(/[?&]$/)) { value += '&'; }
        } else {
          value += '?';
        }
      }

      url_for_coupon.html(value);
    });


    var conditions = form.find('.conditions').children('*:first');

    if (conditions.length) {
      var grow = new h.autogrow(form.find('#campaign_item_condition'));

      conditions.find('.select input').click(function() {
          conditions.attr('class', $(this).val() + '_opened');
          grow.copy();
      });
    };

    var limits              = form.find('.limits > div:first'),
        limit_value_input   = $('#campaign_publisher_reward_limit'),
        limited_input       = $('#campaign_publisher_reward_limit_type_limited');

    var publisher_reward_limit_radios = 
      new h.RadioWatch(limits, function (value) {
        limits.attr('class', value);
      });

    publisher_coupon_type.bind(function (value) {
      if (value == 'percent') {
        limited_input.attr('disabled', true)
          .parent().hide();

        if (limited_input.prop('checked')) {
          publisher_reward_limit_radios.select(0);
        }
      } else {
        limited_input.removeAttr('disabled')
          .parent().show();
      };
    });

    (function() {
        var input = $('#campaign_offer_duration'),
            hint = input.next(),
            last_val = input.val();

        input.bind('change blur keyup', function() {
            var val = input.val() - 0;

            if (isNaN(val) || last_val == val) { return; }

            last_val = val;

            hint.html(
                I18n.t('campaign_form.hour', { 'count': val })
            );
        });
    })();

    var rewards = form.find('.rewards'),
        label = form.find('label[for="campaign_publisher_reward"]');

    var budget_block = form.find('.budget');
    $('#campaign_unlimited_budget').click(function() {
        budget_block.toggleClass('open', !$(this).prop('checked'));
    });

    var title_field = $('#campaign_title'),
        utm_campaign_field = $('#campaign_utm_campaign');

    title_field.blur(function () {
      if (!utm_campaign_field.val()) {
        utm_campaign_field.val(title_field.val().replace(/[ ]/g, '_').toLowerCase());
      };
    });

    (function () {
      var block = $('#publisher_coupon');

      publisher_cashout_method.bind(function (value) { 
        block.toggleClass('abra', value == 'store_coupon'); })

      publisher_coupon_type.bind(function (value) { 
        block.toggleClass('cadabra', value == 'percent'); 
        block.toggleClass('cada', value == 'currency'); 
      });

      publisher_reward_type.bind(function (value) { 
        block.toggleClass('bra', value == 'currency'); })

      $('#campaign_use_publisher_coupon_list').on('click', function () {
        block.toggleClass('open', $(this).prop('checked'));
      });
    })();

    (function () {
      var selects = $('#campaign_publisher_coupon_list_id, #campaign_coupon_list_id'),
          last,
          url = h.current.new_coupon_list_url;

      selects.
        bind('change click', function () {
          if ($(this).val() == 'add') {
            window.open(url, 'new_coupon_list');
            last = $(this);
          };
        }).
        append(
          $('<option/>', { 'value': 'add', 'text': I18n.t('campaign_form.add') })
        );

      h.updateCouponListSelect = function (coupon_list) {
        if (!last) return;

        $('<option/>', { 'value': coupon_list.id, 'html': coupon_list.full_title }).
          insertBefore(selects.find('option:last'));

        last.val(coupon_list.id);
      };
    })();
});
