module ApplicationHelper

  def user_header_auth_links
    if user_signed_in?
      [my_profile_link, sign_out_link]
    else
      [login_link, sign_up_link]
    end.join(' | ')
  end

end
