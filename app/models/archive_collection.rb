# == Schema Information
#
# Table name: archive_collections
#
#  id            :integer          not null, primary key
#  prev_id       :integer
#  next_id       :integer
#  us            :string(2047)     not null
#  with_user     :string(1023)     not null
#  with_server   :string(1023)     not null
#  with_resource :string(1023)     not null
#  utc           :datetime         not null
#  change_by     :string(3071)
#  change_utc    :datetime
#  deleted       :integer
#  subject       :string(1023)
#  thread        :string(1023)
#  crypt         :integer
#  extra         :text(16777215)
#

# == Schema Information
#
# Table name: archive_collections
#
#  id            :integer          not null, primary key
#  prev_id       :integer
#  next_id       :integer
#  us            :string(2047)     not null
#  with_user     :string(1023)     not null
#  with_server   :string(1023)     not null
#  with_resource :string(1023)     not null
#  utc           :datetime         not null
#  change_by     :string(3071)
#  change_utc    :datetime
#  deleted       :integer
#  subject       :string(1023)
#  thread        :string(1023)
#  crypt         :integer
#  extra         :text(16777215)
#

class ArchiveCollection < ActiveRecord::Base
  has_many :archive_messages, foreign_key: :coll_id, dependent: :delete_all

  scope :newest, order(change_utc: :desc)
  scope :last_week, lambda { where("utc >= :date", :date => 1.week.ago) }
  scope :past_week, lambda { where("utc >= :start_date AND utc <= :end_date", {:start_date => 1.week.ago, :end_date => 1.day.ago }) }

  def get_location
    Location.where(user_usid: self.us.split('@').first.split('_').last ).first
  end
end
