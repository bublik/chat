require "spec_helper"

describe Notification do
  describe "feedback" do
    let(:site) { FactoryGirl.create(:site) }
    let(:site_feedback) { FactoryGirl.create(:site_feedback, site: site) }
    let(:mail) { Notification.feedback(site_feedback) }

    it "renders the headers" do
      mail.subject.should match(/Feedback/)
      mail.to.should eq([site_feedback.site.agent.email])
      mail.from.should eq(["noreply@helperchat.com"])
    end

  end

end
