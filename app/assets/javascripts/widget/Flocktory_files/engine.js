(function () {
    var self = window.I18n = {};

    self['locales'] = {};

    self.store_translations = function(locale, hash) {
        var target = self['locales'][locale] = 
                self['locales'][locale] || {};
        
        for(var key in hash) {
            target[key] = hash[key];
        };
    };

    self.set_locale = function(locale) {
      if (self['locales'][locale]) {
        self.locale = self['locales'][locale];
        self.loaded = true;

      } else {
        Modernizr.load(
          {
            load: '/assets/' + locale + '.js',
            complete: function () {
              self.locale = self['locales'][locale];
              self.loaded = true;
            }
          }
        )
      }
    };

    self.translate = function(key, options) {
        var options = options || {};

        if(options['scope']) {
            key = options['scope'] + '.' + key;
        };

        if(typeof(options['count']) != 'undefined') {
            var plural_key = self.plural_key(options['count']);

            if (plural_key) {
                key += '.' + plural_key;
            };
        };

        var value = self.locale[key];

        if (value) {
            return value;
        } else {
            var a = key.split('.');

            return '<span class="translation_missing" title="translation missing: ' + 
                key + 
                '">' + 
                a[a.length-1] + 
                '</span>';
        };
    };

    self.t = self.translate;

    self.localize = function(date, format) {
      return self.locale['_localize'](date, format);
    },

    self.l = self.localize,

    self.plural_key = function(count) {
        var f = self.locale['_pluralize'];
        return f ?
            f(count) :
            null;
    };
})();
