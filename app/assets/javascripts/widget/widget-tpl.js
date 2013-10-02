window.ch_button = '<div id="btn-<%= btn.id %>" class="shf shf_btn shf_btn_<%= btn.side %> shf_btn_<%= btn.side %>_<%= btn.position %> shf_monitor" style="right:0; bottom:0; text-shadow: 1px 1px 1px #202020; border: 1px solid #000; position: fixed; z-index: 10000; background-color: <%= btn.color %>">' +
    '<div class="shf shf_logo"><div class="shf shf_logo_cell"><img class="shf shf_logo_btn" src="<%= btn.logo %>"></div></div>' +
    '<div class="shc shf_title_text" >Online Help</div>';


window.ch_fedback_form = '<div id="ch_feedback_box"><form name="ch_offline_feedback">' +
    '<div><%= data.offline_welcome_message %></div>'+
    '<div><label><%= data.locale.name_field %></label><input type="text" name="site_feedback[username]" id="ch_name" /></div>' +
    '<div><label><%= data.locale.email_field %></label><input type="text" name="site_feedback[email]" id="ch_email" /></div>' +
    '<div><label><%= data.locale.phone_field %></label><input type="text" name="site_feedback[phone]" id="ch_phone" /></div>' +
    '<div><label><%= data.locale.message_field %><br/></label><textarea name="site_feedback[message]" id="ch_message" /></div>' +
    '<input type="submit" value="<%= data.locale.submit_btn %>" id="btn_offline_feedback">' +
'</form></div>'

/*
 Agent template
 Variables: name, avatar, status_text, status_image
*/

window.ch_agent_tpl =
'<div class="shf_agent">' +
  '<div class="shf_photo"><img class="shf_avatar" src="<%= data.avatar_path %>" /></div>' +
    '<div class="shf_mess_details"><%= data.name %>'+
    '<div class="shf_agent_status <%= data.status_text %>"><span></span><em><%= data.status_text %></em></div>' +
    '</div>' +
'</div>';

/*
 Message template
 Variables: avatar_path, full_name, content, time_at
 */

window.ch_message_tpl =
'<div class="shf_message">' +
    '<div class="shf_mess_content">' +
      '<div class="shf_mess_details">' +
        '<div class="shf_mess_time"><%= msg.time_at %></div>' +
        '<div class="shf_mess_nick shf_mess_nick_sel"><%= msg.full_name %></div>' +
      '</div>' +
      '<div class="shf_mess_text" ><div id="shf_"><%= msg.content %></div></div>' +
    '</div><div class="shf_clear"></div>' +
  '</div>' +
'</div>';

/*
 :name, :domain, :color, :side, :position, :title_online,
 :title_offline, :show_offline, :show_offline, :auto_open
 */
// TODO replace to + line style spliter

window.ch_widget_tpl = '<div class="shf_chat" id="widg-<%= config.id %>" style="position: fixed; height: 390px; width: 450px; background-color: <%= config.color %>">' +
  '<div class="shf_header">' +
    '<div class="shf_top_buttons">' +
      '<div class="chf_ico chf_ico_close" title="<%= config.locale.close_dialog %>"></div>' +
      '<div class="chf_ico chf_ico_hide" title="<%= config.locale.hide %>"></div>' +
    '</div>' +
    '<div id="facebookG">' +
      '<div id="blockG_1" class="facebook_blockG"></div>' +
      '<div id="blockG_2" class="facebook_blockG"></div>' +
      '<div id="blockG_3" class="facebook_blockG"></div>' +
    '</div>' +
    '<div class="shf_header_info">' +
//      '<div class="shf_header_logo">' +
//        '<div class="shf_header_logo_cell">' +
//          '<img class="shf_chat_logo" src="<%= config.logo %>">' +
//        '</div>' +
//      '</div>' +
      '<div class="shf_title"><%= config.title %></div>' +
    '</div>' +
  '</div>' +
  '<div id="shf_container" class="shw">' +
    '<div class="shf_agent"></div>' +
    '<div class="shf_messages" >' +
      '<div id="shf_messages" class="shf_messages shf_scrollbar" >' + '<!-- render messages -->' + '</div>' +
    '</div>' +
    '<div class="shf_footer" >' +
      '<div class="shf_textarea_answer"><textarea class="shw" placeholder="<%= config.locale.placeholder %>" name="text"></textarea>' +
      '<div class="shf_enter_ico" title="<%= config.locale.submit_btn%>"></div>' +
      '</div>' +
    '</div>' +
  '</div>' +
  '<audio preload id="chat_new_message">'+
    // AAC file (Chrome/Safari/IE9)
      '<source src="<%= config.asset_host %>/sound/sound.m4a" type="audio/mpeg" />' +
    // Ogg Vorbis (Firefox)
      '<source src="<%= config.asset_host %>/sound/sound.ogg" type="audio/ogg" />'+
  '</audio>' +
  '<div class="shf_copyright" >' +
    '<a href="http://helperchat.com" target="_blank" title="HelperChat" class="shw">Powered by <span class="shw">Helper</span>Chat</a>' +
  '</div>' +
'</div>';