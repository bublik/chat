json.array!(@talks) do |talk|
  json.extract! talk, :site_id, :user_sid
  json.url talk_url(talk, format: :json)
end
