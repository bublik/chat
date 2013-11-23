require 'spec_helper'

describe Site do
  describe 'Validate' do
    subject { FactoryGirl.create(:site) }
    it { should be_valid }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:domain) }
    it { should validate_presence_of(:uuid) }
  end
end
