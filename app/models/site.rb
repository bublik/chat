class Site  < ActiveRecord::Base
  ## Constants
  SIDE = %w( bottom top right left)
  POSITION = %w( right center left)

  ## Relations
  belongs_to :site_category
  belongs_to :agent

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

  before_save do |site|
    site.uuid = UUID.new.generate(:compact) if site.uuid.blank?
  end

  def to_param
    uuid
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
