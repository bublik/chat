class Site  < ActiveRecord::Base
  ## Constants
  SIDE = %w( bottom top right left)
  POSITION = %w( right center left)

  # blue #666699 orange #cc6633 yellow #cc9933 салат #999933 черн #000
  COLORS = %w(#666699 #cc6633 #cc9933 #999933 #000000)
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
    site.color ||= COLORS.first
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
