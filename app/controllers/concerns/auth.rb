module Auth
  extend ActiveSupport::Concern

  included do
    before_filter :authenticate_agent!
    before_filter :signup_master
    layout 'management'
  end

  def grant_cross_domain
    # http://www.w3.org/TR/cors/
    response.headers["Access-Control-Allow-Origin"] = '*'
    response.headers["Access-Control-Allow-Credentials"] = 'true'
    response.headers["P3P"] = 'CP="IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT"'

    # response.headers["Access-Control-Allow-Methods"] = 'GET, POST, XMODIFY'
    #response.headers["Access-Control-Request-Method"] = 'POST'
  end

  def signup_master
    # redirect user to create jabber agent after registration.
    if !current_agent.user && !controller_name.eql?('users')
      redirect_to new_user_path
      return false
    end
  end
end