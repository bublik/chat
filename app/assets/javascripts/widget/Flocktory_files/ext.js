h.inherits = function(child, parent) {
    function temp() {};
    temp.prototype = parent.prototype;
    child.superClass_ = parent.prototype;
    child.prototype = new temp();
    child.prototype.constructor = child;
};

h.sanitize = function (text) {
  return text.
    replace(/&/g, '&amp;').
    replace(/</g, '&lt;').
    replace(/>/g, '&gt;').
    replace(/\n/g, '<br/>');
};
