module Auth
  extend ActiveSupport::Concern

  included do
    before_filter :authenticate_agent!
  end

end