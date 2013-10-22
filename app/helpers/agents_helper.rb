module AgentsHelper

  def login_link
    link_to('Login', login_path)
  end

  def sign_up_link
    link_to('Sign Up', signup_path)
  end

  def my_profile_link
    link_to(current_agent.full_name, edit_agent_registration_path)
  end

  def sign_out_link
    link_to('Sign out', destroy_agent_session_path, method: :delete)
  end

  def subscribe_link(resource)
    path = resource.subscription ? resource.subscription : new_subscription_path
    link_to(icon('icon-credit-card') + resource.plan.name_for_selector, path, class: 'btn btn-primary')
  end

  AUTO_LINK_RE = %r{(?: ([0-9A-Za-z+.:-]+:)// | www\. ) [^\s<]+}x
  AUTO_LINK_CRE = [/<[^>]+$/, /^[^>]*>/, /<a\b.*?>/i, /<\/a>/i]

  def auto_link_urls(text, html_options = {}, options = {})
    link_attributes = html_options.stringify_keys
    text.gsub(AUTO_LINK_RE) do
      scheme, href = $1, $&
      punctuation = []

      if auto_linked?($`, $')
        # do not change string; URL is already linked
        href
      else
        # don't include trailing punctuation character as part of the URL
        while href.sub!(/[^\w\/]$/, '')
          punctuation.push $&
          if opening = BRACKETS[punctuation.last] and href.scan(opening).size > href.scan(punctuation.last).size
            href << punctuation.pop
            break
          end
        end

        link_text = block_given? ? yield(href) : href
        href = 'http://' + href unless scheme

        unless options[:sanitize] == false
          link_text = sanitize(link_text)
          href = sanitize(href)
        end
        content_tag(:a, link_text, link_attributes.merge('href' => href), !!options[:sanitize]) + punctuation.reverse.join('')
      end
    end
  end

  # Detects already linked context or position in the middle of a tag
  def auto_linked?(left, right)
    (left =~ AUTO_LINK_CRE[0] and right =~ AUTO_LINK_CRE[1]) or
        (left.rindex(AUTO_LINK_CRE[2]) and $' !~ AUTO_LINK_CRE[3])
  end

end
