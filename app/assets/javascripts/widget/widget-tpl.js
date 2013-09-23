window.ch_button = '<div id="btn-<%= btn.id %>" class="shf shf_btn shf_btn_<%= btn.side %> shf_btn_<%= btn.side %>_<%= btn.position %> shf_monitor" style="right:0; bottom:0; text-shadow: 1px 1px 1px #202020; border: 1px solid #000; position: fixed; z-index: 10000; background-color: <%= btn.color %>">' +
    '<div class="shf shf_logo"><div class="shf shf_logo_cell"><img rel="logo" class="shf shf_logo_btn" src="<%= btn.logo %>"></div></div>' +
    '<div class="shc shf_title_text" rel="title">Online Help</div>'


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
'</div>'

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
      '<div class="shf_mess_text" rel="text"><div id="shf_"><%= msg.content %></div></div>' +
    '</div><div class="shf_clear"></div>' +
  '</div>' +
'</div>';

/*
 :name, :domain, :color, :side, :position, :title_online,
 :title_offline, :show_offline, :show_offline, :auto_open
 */
// TODO replace to + line style spliter

window.ch_widget_tpl = '<div class="shf_chat" id="widg-<%= config.id %>" style="position: fixed; height: 390px; width: 450px; background-color: <%= config.color %>">' +
  '<div class="shf_header" rel="header">' +
    '<div class="shf_top_buttons">' +
      '<div rel="close" class="chf_ico chf_ico_close" title="<%= config.close_dialog %>"></div>' +
      '<div rel="hide" class="chf_ico chf_ico_hide" title="<%= config.hide %>"></div>' +
    '</div>' +
    '<div id="facebookG">' +
      '<div id="blockG_1" class="facebook_blockG"></div>' +
      '<div id="blockG_2" class="facebook_blockG"></div>' +
      '<div id="blockG_3" class="facebook_blockG"></div>' +
    '</div>' +
    '<div class="shf_header_info">' +
//      '<div class="shf_header_logo">' +
//        '<div class="shf_header_logo_cell">' +
//          '<img rel="logo" class="shf_chat_logo" src="<%= config.logo %>">' +
//        '</div>' +
//      '</div>' +
      '<div class="shf_title" rel="title"><%= config.title %></div>' +
    '</div>' +
  '</div>' +
  '<div id="shf_container" class="shw">' +
    '<div class="shf_messages" rel="online">' +
     '<div class="shf_agent"></div>' +
      '<div id="shf_messages" class="shf_messages shf_scrollbar" rel="scrollbar">' +
      '<!-- render messages -->' +
      '</div>' +
      '<div class="shf_footer" rel="footer">' +
        '<div class="shf_textarea_answer"><textarea class="shw" placeholder="<%= config.placeholder %>" name="text"></textarea>' +
          '<div class="shf_enter_ico" rel="enter" title="<%= config.submit_btn%>"></div>' +
        '</div>' +
      '</div>' +
    '</div>' +
  '</div>' +
  '<div class="shf_copyright" rel="copyright">' +
    '<a href="http://helperchat.com" target="_blank" title="HelperChat" class="shw">Powered by <span class="shw">Helper</span>Chat</a>' +
  '</div>' +
'</div>';