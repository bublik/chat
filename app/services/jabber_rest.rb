require 'rest_client'

# j = JabberRest.new({to: 'admin@helperchat.com', from: 'system@system/rest', message: 'text mesage'})
# j.send!
class JabberRest
  include ActionView::Helpers
  include ActiveModel::Validations
  include ActiveModel::Validations::Callbacks

  attr_accessor :from, :to, :body, :status, :response_body

  validates :from, presence: true
  validates :to, presence: true
  validates :body, presence: true

  def initialize(args)
    @from = args[:from] ||= "noreply@system/rest"
    @to = args[:to]
    @body = args[:body]
  end

  def send!
    return false unless valid?
    # wget http://helperchat.com:5285/rest/ --server-response --post-data '<message to="wax_duzer@helperchat.com/QIP" from="helperchat@helperchat.com/rest"><body>World</body></message>'
    response = RestClient.post "http://#{APP_CONFIG['JABBER_HOST']}:5285/rest/", message
    @status = response.code
    @response_body = response.to_str
  end

  def success?
    status.eql?(200)
  end

  def fail?
    !success?
  end

  def message
    "<message to='#{to}' from='#{from}'><body>#{sanitize(body)}</body></message>"
  end

end