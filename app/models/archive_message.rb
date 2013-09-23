class ArchiveMessage < ActiveRecord::Base
  belongs_to :archive_collection, foreign_key: :coll_id

end
