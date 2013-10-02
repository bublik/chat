h.colors = {
  'from_hex': function(string) {
    var rgb = [];

    string = string.replace(/[^0-9a-fA-F]/, '');

    if (string.length == 3) {
      for (var i = 0; i < 3; i++) {
        rgb.push(parseInt(string[i] + string[i], 16));
      }
    } else if (string.length == 6) {

      for (var i = 0; i < 3; i++) {
        rgb.push(parseInt(string[i * 2] + string[i * 2 + 1], 16));
      }

    }

    return rgb;
  },

  'to_hex': function(rgb) {
    var result = '#';

    for (var i = 0; i < 3; i++) {
      var part = rgb[i].toString(16).toLowerCase();
      (part.length < 2) && (part = '0' + part);

      result += part;
    }

    return result;
  },

  'rgb_to_hsl': function(rgb) {
    var r = rgb[0] / 255,
        g = rgb[1] / 255,
        b = rgb[2] / 255,

        max = Math.max(r, g, b),
        min = Math.min(r, g, b),

        h, s, l = (max + min) / 2;

    if (max == min) {
        h = s = 0;
    } else {
        var d = max - min;
        s = l > 0.5 ? d / (2 - max - min) : d / (max + min);
        switch (max) {
            case r: h = (g - b) / d + (g < b ? 6 : 0); break;
            case g: h = (b - r) / d + 2; break;
            case b: h = (r - g) / d + 4; break;
        }
        h /= 6;
    }

    return [h, s, l];

  },

  'hsl_to_rgb': function(hsl) {
    var h = hsl[0],
        s = hsl[1],
        l = hsl[2],
        r, g, b;

    if (s == 0) {
        r = g = b = l; // achromatic
    } else {
        function hue2rgb(p, q, t) {
            if (t < 0) t += 1;
            if (t > 1) t -= 1;
            if (t < 1 / 6) return p + (q - p) * 6 * t;
            if (t < 1 / 2) return q;
            if (t < 2 / 3) return p + (q - p) * (2 / 3 - t) * 6;
            return p;
        }

        var q = l < 0.5 ? l * (1 + s) : l + s - l * s;
        var p = 2 * l - q;
        r = hue2rgb(p, q, h + 1 / 3);
        g = hue2rgb(p, q, h);
        b = hue2rgb(p, q, h - 1 / 3);
    }

    return [
      Math.round(r * 255),
      Math.round(g * 255),
      Math.round(b * 255)
    ];
  },

  'lighten': function(hex, amount) {
    var rgb = h.colors.from_hex(hex),
        hsl = h.colors.rgb_to_hsl(rgb);

    hsl[2] += amount / 100;
    hsl[2] = Math.max(Math.min(hsl[2], 1), 0);

    return h.colors.to_hex(h.colors.hsl_to_rgb(hsl));
  }
};
