json.cache! [@site, I18n.locale], expires_in: 15.minutes do
  json.extract! @site, :btn_title, :name, :domain, :color, :side, :position, :collect_stats, :title_online, :title_offline, :auto_open, :auto_open_timeout, :sales_welcome_message, :offline_welcome_message, :enabled
  json.agent @site.agent.widget_json
  json.logo asset_url('live_chat.png')
  json.bosh_url APP_CONFIG['BOSH_URL']
  json.bosh_domain APP_CONFIG['BOSH_DOMAIN']
  json.locale t('widget')
end