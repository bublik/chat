//window.ch_button = '<div id="sh_button" class="shc sh_btn sh_btn_right sh_btn_right_center sh_monitor" style="visibility: visible; top: 151px;"><div class="shc sh_logo"><div class="shc sh_logo_cell"><img rel="logo" class="shc sh_logo_btn" src="//mediacdn.siteheart.com/widget/sh/20130824010022/img/logo.png"></div></div><div class="shc sh_title_text" rel="title"><div class="shc sh_btn_char">П </div><div class="shc sh_btn_char">о </div><div class="shc sh_btn_char">м </div><div class="shc sh_btn_char">о </div><div class="shc sh_btn_char">щ </div><div class="shc sh_btn_char">ь </div><div class="shc sh_btn_char">  </div><div class="shc sh_btn_char">о </div><div class="shc sh_btn_char">н </div><div class="shc sh_btn_char">л </div><div class="shc sh_btn_char">а </div><div class="shc sh_btn_char">й </div><div class="shc sh_btn_char">н </div></div><div class="shc sh_block_counter" title="Посетителей на сайте"><span rel="counter">0</span></div><div class="shc sh_pay_logo"><div class="shc sh_pay_box"><div class="shc sh_visa_logo"></div><div class="shc sh_pay_box_title">Доверенный предприниматель </div><div class="shc sh_pay_box_description">В этом чате вы можете оплатить покупку картами VISA/MasterCard. </div><div class="shc sh_triangle"></div><div class="shc sh_triangle_white"></div></div></div></div>'
/*
 :name, :domain, :color, :side, :position, :title_online,
 :title_offline, :show_offline, :show_offline, :auto_open, :disabled
*/
 window.ch_widget_tpl = '\
<div class="shf_chat" id="chw-<%= config.id %>" style="position: absolute; height: 395px; width: 450px;">\
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
    <div class="shf_online_box" rel="online">\
      <div id="shf_messages" class="shf_messages shf_scrollbar" rel="scrollbar" style="height: 239px;">\
        <div class="shf_message">\
          <div class="shf_photo"><img class="shf_avatar" src="<%= config.avatar_path %>"></div>\
            <div class="shf_mess_content">\
              <div class="shf_mess_details">\
                <div class="shf_mess_time">14:09</div>\
                <div class="shf_mess_nick shf_mess_nick_sel">SiteHeart</div>\
              </div>\
              <div class="shf_mess_text" rel="text">\
                <div id="shf_">Can I help you?</div>\
              </div>\
            </div>\
            <div class="shf_clear"></div>\
          </div>\
        </div>\
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
</div>'