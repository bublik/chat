module UsersHelper

  def login_link
    link_to('Login', login_path)
  end

  def sign_up_link
    link_to('Sign Up', signup_path)
  end

  def my_profile_link
    link_to(current_user.full_name, edit_user_registration_path)
  end

  def sign_out_link
    link_to('Sign out', destroy_user_session_path, method: :delete)
  end

end
