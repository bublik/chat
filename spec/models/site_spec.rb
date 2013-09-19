# == Schema Information
#
# Table name: sites
#
#  name             :string(255)      not null
#  domain           :string(255)      not null
#  site_category_id :integer
#  agent_id         :integer
#  color            :string(255)      not null
#  side             :string(255)      not null
#  position         :string(255)      not null
#  title_online     :string(255)
#  title_offline    :string(255)
#  collect_stats    :boolean          default(FALSE)
#  show_online      :boolean          default(TRUE)
#  show_offline     :boolean          default(FALSE)
#  auto_open        :boolean          default(FALSE)
#  enabled          :boolean          default(TRUE)
#  created_at       :datetime
#  updated_at       :datetime
#  id               :integer          not null, primary key
#  uuid             :string(255)      not null
#

require 'spec_helper'

describe Site do
  pending "add some examples to (or delete) #{__FILE__}"
end
