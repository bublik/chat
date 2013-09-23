class ArchiveCollection < ActiveRecord::Base
  has_many :archive_messages, foreign_key: :coll_id, dependent: :delete_all

end
