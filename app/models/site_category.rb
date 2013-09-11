class SiteCategory
  has_many :sites

  field :name
  validates_presence_of :name

end
