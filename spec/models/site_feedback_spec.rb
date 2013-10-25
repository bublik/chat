# == Schema Information
#
# Table name: site_feedbacks
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  email      :string(255)
#  phone      :string(255)
#  message    :text
#  referer    :string(255)
#  remote_ip  :string(255)
#  user_agent :string(255)
#  site_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

# == Schema Information
#
# Table name: site_feedbacks
#
#  id         :integer          not null, primary key
#  username   :string(255)
#  email      :string(255)
#  phone      :string(255)
#  message    :text
#  referer    :string(255)
#  remote_ip  :string(255)
#  user_agent :string(255)
#  site_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'spec_helper'

describe SiteFeedback do
  pending "add some examples to (or delete) #{__FILE__}"
end
