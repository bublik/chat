module SitesHelper

  def widget_js
    'localhost:3000/assets/chf.js'
  end

  def widget_code(site = nil)
    return unless site
    javascript_tag do
      "_shcp = {widget_id: \"#{site.id}}\";
(function() { var chs = document.createElement(\"script\");
 chs.type = \"text/javascript\"; chs.async = true;
chs.src = (\"https:\" == document.location.protocol ? \"https\" : \"http\")+\"://#{widget_js}\";
var s = document.getElementsByTagName(\"script\")[0];
s.parentNode.insertBefore(chs, s.nextSibling); })();"
    end

  end

end
