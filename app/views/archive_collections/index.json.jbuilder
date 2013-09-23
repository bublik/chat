json.array!(@archive_collections) do |archive_collection|
  json.extract! archive_collection, :us, :with_user, :utc, :change_by, :change_utc
  json.url archive_collection_url(archive_collection, format: :json)
end
