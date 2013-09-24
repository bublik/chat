# == Schema Information
#
# Table name: archive_messages
#
#  id      :integer          not null, primary key
#  coll_id :integer          not null
#  utc     :datetime         not null
#  dir     :integer
#  body    :text(16777215)
#  name    :string(1023)
#

class ArchiveMessage < ActiveRecord::Base
  belongs_to :archive_collection, foreign_key: :coll_id

end
