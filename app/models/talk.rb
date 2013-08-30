class Talk
  include Mongoid::Document

  ## Relations
  belongs_to :site, index: true
  belongs_to :user, index: true
  embeds_many :messages

  ## Fields
  field :site_id, type: String
  # will be enabled when Operator joined to talk
  field :user_sid, type: String
  field :remote_ip, type: String
  field :referer, type: String
  field :user_agent, type: String

  ## Validations
  validates_presence_of :site_id
  validates_presence_of :remote_ip
  validates_presence_of :referer
  validates_presence_of :user_agent

end
