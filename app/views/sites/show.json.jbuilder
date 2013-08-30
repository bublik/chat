# TODO cache to memcashe
online = true
json.extract! @site, :name, :domain, :color, :side, :position, :title_online, :title_offline, :collect_stats, :show_offline, :show_offline, :auto_open, :disabled
json.logo asset_url('assets/logo.jpeg')
json.avatar_path asset_url('assets/avatar1.jpeg')

# TODO extract to localization file

json.title online ? @site.title_online : @site.title_offline
json.smile 'Смайлик'
json.sound 'Звук'
json.submit_btn 'Отправить'
json.close 'Завершить'
json.close_dialog 'Завершить диалог'
json.popup 'Открыть в новом окне'
json.hide 'Свернуть'
json.send_file_title 'Отправить файл'
json.placeholder 'Введите текст сообщения...'
json.talk_uid @talk_uid
json.private_pub PrivatePub.subscription(:channel => site_talks_path(@site))
