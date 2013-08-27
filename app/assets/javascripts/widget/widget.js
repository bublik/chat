//<div id="btn-' + @site_uid + '" style="position: absolute; z-index: 10000">Online Help</div>

window.ch_button = '<div id="btn-<%= btn.id %>" class="shf shf_btn shf_btn_<%= btn.side %> shf_btn_<%= btn.side %>_<%= btn.position %> shf_monitor" style="position: absolute; z-index: 10000; background-color: <%= btn.color %>">' +
    '<div class="shf shf_logo">' +
    '<div class="shf shf_logo_cell">' +
    '<img rel="logo" class="shf shf_logo_btn" src="<%= btn.logo %>">' +
    '</div>' +
    '</div><div class="shc shf_title_text" rel="title">' +'П о м ' +'о щ ь ' +'  о н ' +'л а й ' +'н </div>' +
    '</div><div class="shc shf_block_counter" title="Посетителей на сайте">' +
    '<span rel="counter">0</span></div><div class="shc shf_pay_logo">' +
    '<div class="shf shf_pay_box"><div class="shc shf_visa_logo"></div>' +
    '<div class="shf shf_pay_box_title">Доверенный предприниматель </div>' +
    '<div class="shf shf_pay_box_description">В этом чате вы можете оплатить покупку картами VISA/MasterCard. </div>' +
    '<div class="shf shf_triangle"></div><div class="shc shf_triangle_white"></div></div></div></div>'

/*
 Message template
 Variables: avatar_path, full_name, content, time_at
 */

window.ch_message_tpl = '\
<div class="shf_message">\
  <div class="shf_photo"><img class="shf_avatar" src="<%= msg.avatar_path %>"></div>\
    <div class="shf_mess_content">\
      <div class="shf_mess_details">\
        <div class="shf_mess_time"><%= msg.time_at %></div>\
        <div class="shf_mess_nick shf_mess_nick_sel"><%= msg.full_name %></div>\
      </div>\
      <div class="shf_mess_text" rel="text">\
        <div id="shf_"><%= msg.content %></div>\
      </div>\
    </div>\
    <div class="shf_clear"></div>\
  </div>\
</div>';

/*
 :name, :domain, :color, :side, :position, :title_online,
 :title_offline, :show_offline, :show_offline, :auto_open, :disabled
 */


window.ch_widget_tpl = '\
<div class="shf_chat" id="widg-<%= config.id %>" style="position: absolute; height: 395px; width: 450px;">\
  <div class="shf_header" rel="header">\
      <div class="shf_top_buttons">\
        <div rel="close" class="chf_ico chf_ico_close" title="<%= config.close_dialog %>"></div>\
        <div rel="popup" class="chf_ico chf_ico_popup" title="<%= config.popup %>"></div>\
        <div rel="hide" class="chf_ico chf_ico_hide" title="<%= config.hide %>"></div>\
      </div>\
      <div class="shf_header_info">\
        <div class="shf_header_logo">\
          <div class="shf_header_logo_cell">\
            <img rel="logo" class="shf_chat_logo" src="<%= config.logo %>">\
          </div>\
        </div>\
        <div class="shf_title" rel="title"><%= config.title %></div>\
      </div>\
  </div>\
<div id="shf_container_root" class="shw">\
  <div id="shf_container" class="shw">\
    <div class="shf_messages" rel="online">\
      <div id="shf_messages" class="shf_messages shf_scrollbar" rel="scrollbar" style="height: 239px;">\
      <!-- render messages -->\
      </div>\
      <div class="shf_footer" rel="footer">\
        <div class="shf_footer_menu_list">\
          <div class="shf_button shf_button_back shf_button_gray_complete" rel="complate"><%= config.close %></div>\
          <div class="shf_footer_menu" rel="attach" title="<%= config.send_file_title %>" style="position: relative;">\
            <div class="shf_ic shf_ic_attach"></div>\
            <div style="position: absolute; left: 0px; top: 0px; overflow: hidden; z-index: 10; width: 28px; height: 30px;">\
              <input type="file" name="file" class="shf_attach_file" style="width: 28px; height: 30px; position: absolute; left: 0px; top: 0px; opacity: 0; cursor: pointer;">\
              </div>\
            </div>\
            <div class="shf_footer_menu" rel="smiles" title="<%= config.smile %>">\
              <div class="shf_ic shf_ic_smiles"></div>\
            </div>\
            <div class="shf_footer_menu" rel="sound" title="<%= config.sound %>">\
              <div class="shf_ic shf_ic_sound"></div>\
            </div>\
          </div>\
          <div class="shf_textarea_answer"><textarea class="shw" placeholder="<%= config.placeholder %>" name="text"></textarea>\
            <div class="shf_enter_ico" rel="enter" title="<%= config.submit_btn%>"></div>\
          </div>\
        </div>\
      </div>\
    </div>\
    <div class="shf_copyright" rel="copyright">\
      <div class="shf_resize" rel="resize"></div>\
      <a href="http://hepler.com.ua" target="_blank" title="SiteHelper" class="shw">\
        <spanclass="shf_copyright_text">Powered by </span><span class="shw">Site</span>Helper</a>\
    </div>\
</div>';