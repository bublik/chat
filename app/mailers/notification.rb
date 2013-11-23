class Notification < ActionMailer::Base
  default from: "noreply@helperchat.com"
  default 'X-Notification-Header' => Proc.new { "Site notification #{Date.current}" }
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.notification.feedback.subject
  #
  def feedback(feedback)
    site = feedback.site
    @feedback = feedback

    mail to: site.agent.email, subject: "Site Feedback #{site.domain}"
  end
end
