class window.ChatFrame
  constructor: (@options) ->
    console.log('Constructor Start with options ->', @options)
    @site_uid = @options['widget_id']
    @button_id = '#btn-' + @site_uid
    @widget_window_id = '#widg-' + @site_uid
    @assets_host = 'site2.com:3000'
    @chat_config_host = 'site2.com:3000'
    @site_config = {id: @site_uid}
    @user_uid = Math.floor(Math.random(1, 100) * 100)
    @sheme = 'http'
    @sheme = 'https' if (document.location.protocol is 'https:')

    @widget_css_url = @sheme + '://' + @assets_host + '/assets/widget.css'
    @lang = (navigator.language || navigator.userLanguage || navigator.systemLanguage || "en").substr(0,
        2).toLowerCase()
    @site_config_url = @sheme + '://' + @chat_config_host + '/sites/' + @site_uid + '.json?lang=' + @lang
    console.log('Constructor Finish \<-')
    @checkCookie()

  load_site_config: ->
    console.log 'load_site_config ->'
    self = @
    jQuery.getJSON @site_config_url, (data) ->
      _.extend(self.site_config, data)
      console.log 'Config LOADED!!! ->', self.site_config
      self.load_css()
      self.init_button()

  init_button: ->
    console.log 'init button ->', @button_id
    if @site_config['disabled'] is '1'
      console.log 'widget DISABLED!'
      return
    jQuery('body').append(_.template(window.ch_button, { btn: @site_config }))

    #@style_button(jQuery(@button_id))
    self = @
    if @site_config['auto_open'] is '1'
      console.log 'widget AUTOOPEN!'
      self.show_widget()

    jQuery(@button_id).on 'click', (e) ->
      console.log 'Click on BUTTON'
      self.show_widget()

  load_css: ->
    console.log 'load_css ->'
    css = document.createElement("link")
    css.media = "all"
    css.rel = 'stylesheet'
    css.href = @widget_css_url
    document.body.appendChild(css)

  position: (_el) ->
    console.log 'position ->', _el.attr('id')
    _el.css(@site_config['side'], 0)
    if @site_config['position'] is 'center'
      _el.css('left', (jQuery(window).width() / 2) - (jQuery(_el).width() / 2))
    else
      _el.css(@site_config['position'], 0)

  bind_widget_events: ->
    self = @
    console.log 'bind events ->'
    jQuery('.chf_ico_close, .shf_button_gray_complete').on 'click', (e) ->
      self.close_widget()
    #    jQuery('.chf_ico_popup').on 'click', (e) ->
    #      self.popup_widget()
    jQuery('.chf_ico_hide').on 'click', (e) ->
      self.hide_widget()
      self.set_presence('away')
    jQuery('.shf_enter_ico').on 'click', (e) ->
      unless $.xmpp.connected
        self.connect()
      self.send_message()
    jQuery('.shf_textarea_answer textarea').on 'focus', (e) ->
      #self.set_presence()
  show_widget: ->
    console.log 'show_widget ->', jQuery(@widget_window_id)
    unless jQuery(@widget_window_id)[0]
      console.log 'Add widget to page'
      jQuery('body').append(_.template(window.ch_widget_tpl, { config: @site_config }))
      @bind_widget_events()
      @connect()

    jQuery(@widget_window_id).fadeIn()
    @position(jQuery(@widget_window_id))

  close_widget: ->
    jQuery(@widget_window_id).hide()
    $.xmpp.disconnect()

  hide_widget: ->
    jQuery(@widget_window_id).fadeOut() #hide()

  # type can be ['', 'dnd', 'away']
  set_presence: (type = null) ->
    $.xmpp.setPresence(type)
  avatar: (user)->
    @sheme + '://' + @site_config.bosh_domain + 'presence/jid/' + user + '/' + @site_config.bosh_domain + '/image/'
  connect: ->
    console.log "Connect:"
    if $.xmpp.connected
      ##@set_presence()
      return true

    self = @
    $.xmpp.connect
      url: @site_config.bosh_url
      jid: 'Guest_' + @user_uid + '@' + @site_config.bosh_domain
      password: ''
#      wait: 10,
#      inactivity: 20,
      onConnect: ->
        console.log "onConnect ->"
      onIq: (iq) ->
        console.log('onIq', iq)
      onNotification: (notification) ->
        console.log("onNotification ->", notification)
      onPresence: (presence) ->
        console.log('onPresence ->', presence)
        console.log 'New presence: ', presence.from
        console.log "SHOW", presence.show
      onDisconnect: ->
        console.log "Disconnected"

      onMessage: (message) ->
        console.log('onMessage', message)
        jid = message.from.split("/")
        if (err = message.data.find('error')).context != undefined
          console.log 'ERROR', jid, err

        msg = {
          time_at: (new Date).toLocaleString().split(' ')[1],
          full_name: jid[0],
          content: message.body,
          avatar_path: self.avatar(jid[0])}
        console.log 'MSG', msg
        self.append_message(msg)
      onError: (error) ->
        console.log error.error
        if error.error.match(/Invalid credentials/)
          alert('Credential')
          self.connect()
#        alert(self.getCookie('ch_csid'))
#        if error.error.match(/Invalid credentials/) and self.getCookie('ch_csid') != ''
#          console.log('MATCH RELOGIN')
#          if $.xmpp.sid = self.getCookie('ch_csid')
#            console.log "Delete OLD session for SID", $.xmpp.sid
#            $.xmpp.disconnect()
#            self.connect()
#        self.setCookie('ch_csid', '')

  append_message: (data) ->
    console.log('append_message <-')
    mesage_content = _.template(window.ch_message_tpl, { msg: data })
    jQuery('#shf_messages').append(mesage_content)
    jQuery('#shf_messages').last().scrollTop(100000).fadeIn('slow')

  current_page: ->
    if jQuery('#shf_messages div').length is 0
      "UserAgent: " + window.navigator.userAgent + "\n" + "Page: " + document.location + "\n"
    else
      ''

  send_message: ->
    @connect()
    input = jQuery('.shf_textarea_answer textarea')
    console.log 'Send message =>'
    chat_session = $('<thread/>').attr('thread', 'asdasd').html('asdasd')
    $.xmpp.sendMessage({to: @site_config.to, body: @current_page() + input.val(), resource: 'support'}, chat_session)

    @append_message({
      time_at: (new Date).toLocaleString().split(' ')[1],
      full_name: 'Guest',
      content: input.val(),
      avatar_path: @avatar('guest') })
    input.val ""

  checkCookie: () ->
    @user_uid = (@getCookie('ch_usid') or @setCookie('ch_usid', @user_uid, 365))

  setCookie: (c_name, value, exdays) ->
    exdate = new Date()
    exdate.setDate exdate.getDate() + exdays
    c_value = escape(value) + ((if (not (exdays?)) then "" else "; expires=" + exdate.toUTCString()))
    document.cookie = c_name + "=" + c_value

  getCookie: (c_name) ->
    c_value = document.cookie
    c_start = c_value.indexOf(" " + c_name + "=")
    c_start = c_value.indexOf(c_name + "=")  if c_start is -1
    if c_start is -1
      c_value = null
    else
      c_start = c_value.indexOf("=", c_start) + 1
      c_end = c_value.indexOf(";", c_start)
      c_end = c_value.length  if c_end is -1
      c_value = unescape(c_value.substring(c_start, c_end))
    c_value

window.cfrm = new window.ChatFrame(window._shcp)
window.cfrm.load_site_config()

#  style_button: (_el) ->
#    console.log('Styled button ->' + _el.attr('id'))
#    _el.css('background-color', @site_config['color'])
#    _el.css('box-shadow', '0 3px 8px rgba(50, 50, 50, 0.17)')
#    _el.css('border', '1px solid ' + @site_config['color'])
#    #@position(_el)

#  create_widget: ->
#    # added frame
#    #TODO add google analytix
#    console.log 'Create chat frame'
#    iframe = document.createElement('iframe')
#    iframe.src = @chat_url
#    iframe.name = 'eg_iframe'
#    iframe.id = 'chf_iframe'
#    iframe.scrolling = 'yes'
#    iframe.frameborder = 'no'
#    iframe.framespacing = 0
#    iframe.border = 0
#
#    iframe.style.width = "100%"
#    iframe.style.height = "100%"
#    iframe.style.border = "0"
#
#    document.getElementById(@site_uid).appendChild(iframe)
#
#    iframeDocument = iframe.contentDocument or iframe.contentWindow.document
#    iframeDocument.open()
#    iframeDocument.write('<!doctype html><html><body><script src=' + @chat_url + ' ><\/script><\/body><\/html>')
#    iframeDocument.close()
#    iframe.src = @chat_url