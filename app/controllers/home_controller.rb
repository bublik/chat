class HomeController < ApplicationController
  before_filter :check_auth

  def index
    render layout: 'home_index'
  end

  def contact
  end

  def help
  end

  def price
  end

  def about
  end

  def releases
  end

  def terms
  end

  def privacy
  end

  def career
  end

  def page404
  end

  private

  def check_auth
    if agent_signed_in?
      redirect_to(management_index_path)
      false
    end
  end

end
