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
end
