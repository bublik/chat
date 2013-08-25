json.array!(@sites) do |site|
json.extract! site, :name, :domain, :site_category_id, :color, :side, :position, :title_online, :title_offline, :collect_stats, :show_offline, :show_offline, :disabled
json.url site_url(site, format: :json)
end
