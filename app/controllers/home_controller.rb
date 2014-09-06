class HomeController < ApplicationController
  before_filter :check_auth, except: :stats

  def index
    render layout: 'home_index'
  end

  def contact
    if request.post?
      flash[:notice] = t('.flash_success')
      # TODO Send contact information
    end
  end

  def help
  end

  def price
    @plans = Plan.order("price")
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

  def sitemap

    render file: "#{Rails.root}/public/sitemap.xml", layout: false
  end

  def stats
    @sites = Site.count
    @sites_last_week = Site.last_week.count
    @sites_past_week = Site.past_week.count
    @messages_last_week = ArchiveMessage.last_week.count
    @messages_past_week = ArchiveMessage.past_week.count
    @conversations_last_week = ArchiveCollection.last_week.count
    @conversations_past_week = ArchiveCollection.past_week.count
    @feedbacks_last_week = SiteFeedback.last_week.count
    @feedbacks_past_week = SiteFeedback.past_week.count
  end

  private

  def check_auth
    if agent_signed_in?
      redirect_to(sites_path)
      false
    end
  end

end
