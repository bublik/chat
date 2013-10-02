$('#customize').each(function() {
    var container = $(this),
        forms = container.find('form.customize_form'),
        next_button = $('.next_button'),
        ie_ol;


    next_button.click(function(e) {
      e.preventDefault();

      tabs.open_next();
      customize_colors.save();

      $('html,body').animate(
          { 'scrollTop': container.offset()['top'] - 20 },
          500
      );
    });

    var twitter_input = $('#campaign_texts_social_twitter'),
        twitter_copy = twitter_input.prevAll('.copy');

    twitter_input.bind('change keyup keypress', function() {
      twitter_copy.html(h.sanitize(twitter_input.prop('value')));
    });

    (function() {
      var fb_title = $('.facebook_title'),
          fb_text = $('.facebook_text'),
          odnoklassniki_title = $('.odnoklassniki_title'),
          odnoklassniki_text = $('.odnoklassniki_text');

      fb_title.bind('change keyup keypress', function() {
        odnoklassniki_title.text(fb_title.prop('value'));
      });

      fb_text.bind('change keyup keypress', function() {
        odnoklassniki_text.text(fb_text.prop('value'));
      });

    })();

    forms.each(function() {
      var $this = $(this);

      $this.data('sensitive_form', new h.sensitiveForm($this, {
        'callback': _.bind(function(changed) {

          this.find('.save_button').prop('disabled', !changed).
            children().toggleClass('disabled', !changed);

          this.data('changed', changed);

        }, $this)
      }));

    }).submit(function(e) {
      e.preventDefault();

      submit_form($(this));
    });

    container.find('textarea').each(function() {
      var $this = $(this);

      $this.data('autogrow', new h.autogrow(this));

      var limit = $this.data('limit');
      if (limit) {
        new h.inputLimit($this, { 'limit': limit});
      }
    });

    var tabs = new h.tabs({
      'tabs': $('#customize_tabs a'),
      'blocks': forms,
      'select_block': function(tab) {
        var target = tab.data('tab');

        if (target == 'friend_popup') {
          return forms.eq(0).addClass('friend');
        } else if (target == 'offer_popup') {
          forms.eq(0).removeClass('friend');

        } else if (target == 'friend_offer_email') {
          $('#campaign_enable_initial_emails').parent().hide();
          $('#campaign_enable_referral_emails').parent().show();
          return forms.eq(1).addClass('friend');
        } else if (target == 'offer_email') {
          $('#campaign_enable_initial_emails').parent().show();
          $('#campaign_enable_referral_emails').parent().hide();
          forms.eq(1).removeClass('friend');
        }
      },
      'callback': function(tab, block) {
        next_button.toggle(!!tab.nextAll().length);

        // http://stackoverflow.com/questions/5584500/ordered-list-showing-all-zeros-in-ie9
        if (ie_ol) {
          ie_ol.hide().show();
          setTimeout(function() {
            ie_ol.css('counter-reset', 'item');
          }, 2);
        }

        block.find('textarea').each(function() {
          var autogrow = $(this).data('autogrow');

          autogrow.copy();
          autogrow.update();
        });
      },
      'before_change': function(e) {
        if ($('form.active').data('changed')) {

          if (!confirm(
              I18n.t('campaign.customize.you_have_unsaved_changes') + ' ' +
              I18n.t('campaign.customize.change_tab')
            )) {

            return false;
          }
        }
      }
    });

    $('#customize_tabs a.active').removeClass('active').trigger('click');

    window.onbeforeunload = function() {
        if ($('form.active').data('changed')) {
          return I18n.t('campaign.customize.you_have_unsaved_changes');
        }
    };

    var submit_form = function(form) {
      var data = {},
          save_button = form.find('button.save_button');

      if (save_button.hasClass('loading')) { return; }

      form.find('textarea, input').each(function() {
        var $this = $(this);
        if (!$this.is(':checkbox') || $this.is(':checked')) {
          data[$this.prop('name')] = $this.val();
        }
      });

      save_button.addClass('loading');

      $.ajax({
        'url': form.prop('action') + '.json',
        'type': 'post',
        'data': _.extend(data, {
          '_method': 'put',
          'authenticity_token': h.current['authenticity_token']
        }),
        'complete': function() {
          form.find('.save_button').removeClass('loading');
        },
        'success': function() {
          form.data('sensitive_form').update_hash();
        }
      });
    };

    $('.default_button').click(function() {
      $('form.active').find('input:text, textarea').filter(':enabled').each(function() {
        var $this = $(this),
            name = $this.attr('name').
              replace(/^.+\[/, '').replace(']', '');

        $this.prop('value',
          (h.current.campaign_texts[name] || '').replace(/(^\n|\n$)/g, '')
        );

        var autogrow = $this.data('autogrow');
        if (autogrow) {
          autogrow.copy();
          autogrow && autogrow.update();
        }
      }).trigger('change');
    });

    var customize_colors = new h.CustomizeColors(
      $('#customize_colors_form'),
      $('#custom_colors_css')
    );

    if ($.browser.msie) {
      ie_ol = container.find('.landing_page_example .instructions ol');
    }
});
