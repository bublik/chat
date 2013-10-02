


var h = window['h'] = {
    current: {},
    _onload: [],
    add: function(f) {
    h._onload ? h._onload.push(f) : f.apply(this);
    },
    run: function() {
    while (h._onload.length) {
        h._onload.splice(0, 1)[0].apply(this);
    }
    h._onload = null;
    }
};

document.documentElement.className = document.documentElement.className.replace('no-js',
    [
      Modernizr.boxshadow ? '' : 'noboxshadow',
      Modernizr.borderradius ? '' : 'borderradius',
      Modernizr.touch ? 'touch' : ''
    ].join(' ')
);
