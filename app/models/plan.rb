# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  price      :integer
#  operators  :integer
#  created_at :datetime
#  updated_at :datetime
#

# == Schema Information
#
# Table name: plans
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  price      :integer
#  operators  :integer
#  created_at :datetime
#  updated_at :datetime
#

class Plan < ActiveRecord::Base
  has_many :subscriptions

  def self.simple
    where('lower(plans.name) = ?', 'simple').first
  end

  def self.good
    where('lower(plans.name) = ?', 'good').first
  end

  def self.better
    where('lower(plans.name) = ?', 'better').first
  end

  def name_for_selector
    I18n.t('prices.'+self.name.downcase)
  end

end
