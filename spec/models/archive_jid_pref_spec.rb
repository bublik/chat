# == Schema Information
#
# Table name: archive_jid_prefs
#
#  us            :string(2047)     not null
#  with_user     :string(1023)     not null
#  with_server   :string(1023)     not null
#  with_resource :string(1023)     not null
#  save          :integer
#  expire        :integer
#  otr           :integer
#

require 'spec_helper'

describe ArchiveJidPref do
  pending "add some examples to (or delete) #{__FILE__}"
end
