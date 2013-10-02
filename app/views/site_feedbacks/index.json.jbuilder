json.array!(@site_feedbacks) do |site_feedback|
  json.extract! site_feedback, :username, :email, :phone, :message, :remote_ip, :user_agent, :site_id
  json.url site_feedback_url(site_feedback, format: :json)
end
