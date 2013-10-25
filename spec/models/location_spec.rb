# == Schema Information
#
# Table name: locations
#
#  id         :integer          not null, primary key
#  user_usid  :string(255)
#  remote_ip  :string(255)
#  address    :string(255)
#  latitude   :float
#  longitude  :float
#  created_at :datetime
#  updated_at :datetime
#  platform   :string(255)      default("")
#  version    :string(255)      default("")
#  browser    :string(255)      default("")
#

require 'spec_helper'

describe Location do
  pending "add some examples to (or delete) #{__FILE__}"
end
