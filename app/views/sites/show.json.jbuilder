json.extract! @site, :name, :domain, :color, :side, :position, :collect_stats, :auto_open, :disabled
json.logo asset_url(@site.logo)
json.title @site.online ? @site.title_online : @site.title_offline
json.smile t('widget.smile')
json.sound t('widget.sound')
json.submit_btn t('widget.submit_btn')
json.close t('widget.close')
json.close_dialog t('widget.close_dialog')
json.popup t('widget.popup')
json.hide t('widget.hide')
json.send_file_title t('widget.send_file_title')
json.placeholder t('widget.placeholder')
json.private_pub PrivatePub.subscription(:channel => talk_push_path(@site.id, @talk_uid))
