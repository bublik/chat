require 'uri'

class Site
  include Mongoid::Document
  include Mongoid::Timestamps

  ## Constants
  SIDE = %w( bottom top right left)
  POSITION = %w( right center left)

  ## Relations
  belongs_to :site_category, index: true
  belongs_to :user, index: true

  ## Fields
  field :name
  field :domain
  #field :site_category_id
  field :color
  field :side
  field :position
  field :title_online
  field :title_offline
  field :collect_stats, type: Boolean
  field :show_online, type: Boolean
  field :show_offline, type: Boolean
  field :auto_open, type: Boolean
  field :disabled, type: Boolean

  ## Validations
  validates_presence_of :name
  validates_presence_of :domain
  #validates_presence_of :site_category_id

  validates :color, format: {with: /\A#\w+\Z/}
  validates :position, inclusion: {in: Site::POSITION}
  validates :side, inclusion: {in: Site::SIDE}

  after_initialize do |site|
    site.color ||= '#003399'
  end

  # TODO add user upload logo on interface
  def logo
    'assets/logo.jpeg'
  end

  # TODO add check if one Manager in online for this site
  def online
    true
  end
end
