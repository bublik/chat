json.array!(@archive_jid_prefs) do |archive_jid_pref|
  json.extract! archive_jid_pref, :with_user, :with_resource, :save, :expire, :otr
  json.url archive_jid_pref_url(archive_jid_pref, format: :json)
end
