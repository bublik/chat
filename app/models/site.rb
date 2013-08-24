require 'uri'

class Site
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Relations
  belongs_to :site_category, index: true
  belongs_to :user, index: true

  ## Fields
  field :name
  field :domain
  field :color
  field :side
  field :position
  field :title_online
  field :title_offline
  field :collect_stats, type: Boolean
  field :show_online, type: Boolean
  field :show_offline, type: Boolean
  field :disabled, type: Boolean

  ## Validations
  validates_presence_of :name
  validates_presence_of :domain
  validates :color, format: {with: /\A#\w+\Z/}
  validates :position, inclusion: {in: %w( right center left)}
  validates :side, inclusion: {in: %w( bottom top right left)}

end
