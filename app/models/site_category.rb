class SiteCategory
  include Mongoid::Document
  include Mongoid::Timestamps

  has_many :sites

  field :name
  validates_presence_of :name

end
