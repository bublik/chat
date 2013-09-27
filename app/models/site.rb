# == Schema Information
#
# Table name: sites
#
#  id                      :integer          not null, primary key
#  name                    :string(255)      not null
#  domain                  :string(255)      not null
#  site_category_id        :integer
#  agent_id                :integer
#  color                   :string(255)      not null
#  side                    :string(255)      not null
#  position                :string(255)      not null
#  title_online            :string(255)      default("")
#  title_offline           :string(255)      default("")
#  collect_stats           :boolean          default(FALSE)
#  show_online             :boolean          default(TRUE)
#  show_offline            :boolean          default(FALSE)
#  auto_open               :boolean          default(FALSE)
#  enabled                 :boolean          default(TRUE)
#  created_at              :datetime
#  updated_at              :datetime
#  uuid                    :string(255)      not null
#  offline_welcome_message :string(255)      default("")
#  auto_open_timeout       :integer          default(3)
#  user_prefix             :string(255)      default("guest")
#

class Site < ActiveRecord::Base
  ## Constants
  SIDE = %w( bottom top right left)
  POSITION = %w( right center left)

  # blue #666699 orange #cc6633 yellow #cc9933 салат #999933 черн #000
  COLORS = %w(#666699 #cc6633 #cc9933 #999933 #3b3b3b)
  ## Relations
  belongs_to :site_category
  belongs_to :agent

  ## Validations
  validates_presence_of :name
  validates_presence_of :domain
  validates_presence_of :uuid

  validates :color, format: {with: /\A#\w+\Z/}
  validates :position, inclusion: {in: Site::POSITION}
  validates :side, inclusion: {in: Site::SIDE}
  validates :auto_open_timeout, numericality: { :greater_than_or_equal_to => 0 }
  validates :offline_welcome_message, length: 6..254

  before_validation(on: :create) do
    self.color ||= COLORS.last
    self.position ||= 'right'
    self.side ||= 'bottom'
    self.uuid ||= UUID.new.generate(:compact)
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
