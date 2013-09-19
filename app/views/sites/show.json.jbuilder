json.extract! @site, :name, :domain, :color, :side, :position, :collect_stats, :auto_open, :disabled
json.agent @site.agent.widget_json
json.logo asset_url('live_chat.png')
json.title @site.online ? @site.title_online : @site.title_offline
json.bosh_url APP_CONFIG['BOSH_URL']
json.bosh_domain APP_CONFIG['BOSH_DOMAIN']
json.smile t('widget.smile')
json.sound t('widget.sound')
json.submit_btn t('widget.submit_btn')
json.close t('widget.close')
json.close_dialog t('widget.close_dialog')
json.popup t('widget.popup')
json.hide t('widget.hide')
json.placeholder t('widget.placeholder')
