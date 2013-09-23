json.array!(@archive_messages) do |archive_message|
  json.extract! archive_message, :utc, :dir, :body, :name
  json.url archive_message_url(archive_message, format: :json)
end
