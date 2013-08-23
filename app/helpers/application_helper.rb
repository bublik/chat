module ApplicationHelper
  def user_header_auth_links
    if user_signed_in?
      [current_user.email, link_to('My info', edit_user_registration_path),
       link_to('Sign out', destroy_user_session_path, method: :delete)]
    else
      [link_to('Login', login_path), link_to('Sign Up', signup_path)]
    end.join(' | ')
  end

  def my_profile
    link_to(current_user.full_name, edit_user_registration_path)
  end

  def sign_out
    link_to('Sign out', destroy_user_session_path, method: :delete)
  end

end
