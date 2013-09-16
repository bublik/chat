json.array!(@users) do |user|
  json.extract! user, :username, :password, :agent_id
  json.url user_url(user, format: :json)
end
