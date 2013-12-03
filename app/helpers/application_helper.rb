module ApplicationHelper

  def agent_header_auth_links
    if agent_signed_in?
      [my_profile_link, sign_out_link]
    else
      [login_link, sign_up_link]
    end.join(' | ')
  end

  def icon(style = nil)
    return unless style
    content_tag(:i, '', class: style)
  end

  def icon_boolean(flag = false)
    flag ? icon('icon-ok') : icon('icon-remove')
  end

  def selected_plan
    Plan.where('LOWER(plans.name) = ? ', params[:plan] || 'simple').first.id
  end

  def helperchat_widget
    '<script type="text/javascript">
    _chcfg = {widget_id: "0a549da0187a01315d22040106cf7601", user_prefix: "helper"};
    (function() { var chs = document.createElement("script");
    chs.type = "text/javascript"; chs.async = true;
    chs.src = ("https:" == document.location.protocol ? "https" : "http")+"://'+APP_CONFIG['HOST']+'/assets/widget.js";
    var s = document.getElementsByTagName("script")[0];
    s.parentNode.insertBefore(chs, s.nextSibling); })();
</script>'.html_safe
  end

  def google_analytix
    "<script>
  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

  ga('create', 'UA-44192749-1', 'helperchat.com');
  ga('send', 'pageview');
</script>".html_safe
  end

  def yandex_metrix
    '<!-- Yandex.Metrika counter -->
<script type="text/javascript">
    (function (d, w, c) {
        (w[c] = w[c] || []).push(function() {
            try {
                w.yaCounter23206129 = new Ya.Metrika({id:23206129,
                    webvisor:true,
                    clickmap:true,
                    trackLinks:true,
                    accurateTrackBounce:true});
            } catch(e) { }
        });

        var n = d.getElementsByTagName("script")[0],
                s = d.createElement("script"),
                f = function () { n.parentNode.insertBefore(s, n); };
        s.type = "text/javascript";
        s.async = true;
        s.src = (d.location.protocol == "https:" ? "https:" : "http:") + "//mc.yandex.ru/metrika/watch.js";

        if (w.opera == "[object Opera]") {
            d.addEventListener("DOMContentLoaded", f, false);
        } else { f(); }
    })(document, window, "yandex_metrika_callbacks");
</script>
<noscript><div><img src="//mc.yandex.ru/watch/23206129" style="position:absolute; left:-9999px;" alt="" /></div></noscript>
<!-- /Yandex.Metrika counter -->'.html_safe
  end

end
