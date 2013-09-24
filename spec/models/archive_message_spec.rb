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

require 'spec_helper'

describe ArchiveMessage do
  pending "add some examples to (or delete) #{__FILE__}"
end
