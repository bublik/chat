class window.ChatFrame
  constructor: (@options) ->
    console.log('Constructor Start with options ->', @options)
    @site_uid = @options['widget_id']
    @button_id = '#btn-' + @site_uid
    @widget_window_id = '#widg-' + @site_uid
    @assets_host = 'site2.com:3000'
    @chat_config_host = 'site2.com:3000'
    @site_config = {id: @site_uid}
    @user_uid = Math.floor(Math.random(1, 100) * 1000)
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
    if @site_config['disabled']
      console.log 'widget DISABLED!'
      return
    jQuery('body').append(_.template(window.ch_button, { btn: @site_config }))

    #@style_button(jQuery(@button_id))
    self = @
    console.log(@site_config['auto_open'])
    if @site_config['auto_open']
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
    jQuery('.chf_ico_hide').on 'click', (e) ->
      self.hide_widget()
      if jQuery.xmpp.connected
        jQuery.xmpp.setPresence('away')
    jQuery('.shf_enter_ico').on 'click', (e) ->
      unless jQuery.xmpp.connected
        self.connect()
      self.send_message()
    jQuery('.shf_textarea_answer textarea').on 'focus', (e) ->
      if jQuery.xmpp.connected
        jQuery.xmpp.setPresence(null)
      else
        self.connect()
    jQuery('.shf_textarea_answer textarea').on 'keyup', (e) ->
      if event.keyCode is 13
       jQuery('.shf_textarea_answer .shf_enter_ico').click()

  show_widget: ->
    console.log 'show_widget ->', jQuery(@widget_window_id)
    unless jQuery(@widget_window_id)[0]
      console.log 'Add widget to page'
      jQuery('body').append(_.template(window.ch_widget_tpl, { config: @site_config }))
      @bind_widget_events()
      @connect()

    jQuery(@widget_window_id).fadeIn()
    @position(jQuery(@widget_window_id))
    @scroll_messages() # show new messages when widget window minimized and Operator was sent messages

  close_widget: ->
    jQuery(@widget_window_id).hide()
    jQuery.xmpp.disconnect()

  hide_widget: ->
    jQuery(@widget_window_id).fadeOut() #hide()

  connect: ->
    console.log "Connect:"
    self = @
    jQuery.xmpp.connect
      url: @site_config.bosh_url
      jid: 'guest_' + @user_uid + '@' + @site_config.bosh_domain
      password: ''
      onConnect: ->
        console.log "onConnect ->"
        jQuery.xmpp.setPresence(null)
        console.log 'jQuery.xmpp.sid', jQuery.xmpp.sid
      onIq: (iq) ->
        console.log('onIq', iq)
      onNotification: (notification) ->
        console.log("onNotification ->", notification)
      onPresence: (presence) ->
        console.log('onPresence ->', presence)
        console.log 'New presence: ', presence.from
        console.log "SHOW", presence.show
        curId = presence.from.split('@')[0]
        status_icon = "available_icon"
        switch presence.show
          when "dnd"
            status_icon = "busy_icon"
          when "away"
            status_icon = "away_icon"
          else
            status_icon = "available_icon"
        console.log('onpresence', status_icon)

      onDisconnect: ->
        jQuery.xmpp.connected = false
        console.log "Disconnected ans start Connect->"
        self.connect()

      onMessage: (message) ->
        console.log('onMessage', message)
        if (err = message.data.find('error')).context != undefined
          console.log 'ERROR', message.from, err
        msg = {
          time_at: (new Date).toLocaleString().split(' ')[1],
          full_name: self.site_config.operator.name,
          content: message.body}
        console.log 'MSG', msg
        self.append_message(msg)
      onError: (error) ->
        console.log error.error
        if error.error.match(/Invalid/)
          console.log 'jQuery.xmpp.sid', jQuery.xmpp.sid
          console.log 'CALL DISCONNECT'
          jQuery.xmpp.disconnect()

  append_message: (data) ->
    console.log('append_message <-')
    if _.isEmpty(data.content)
      console.log('empty message, exit')
      return
    mesage_content = _.template(window.ch_message_tpl, { msg: data })
    jQuery('#shf_messages').append(mesage_content)
    @scroll_messages()

  scroll_messages: ()->
    jQuery('#shf_messages').last().scrollTop(100000).fadeIn('slow')
  current_page: ->
    if jQuery('#shf_messages div').length is 0
      "UserAgent: " + window.navigator.userAgent + "\n" + "Page: " + document.location + "\n"
    else
      ''

  send_message: ->
    input = jQuery('.shf_textarea_answer textarea')
    if input.val() == ''
      return
    console.log 'Send message =>'
    # jQuery.xmpp.sendCommand("<presence from='"+ $.xmpp.jid+"' to='"+@site_config.to+"' type='subscribe'/>")
    # type chat, private, groupchat and default  chat
    jQuery.xmpp.sendMessage({ type: 'private', to: @site_config.operator.email, body: @current_page() + input.val()})

    @append_message({
      time_at: (new Date).toLocaleString().split(' ')[1],
      full_name: 'You',
      content: input.val() })
    input.val ""
  checkCookie: () ->
    @user_uid = (@getCookie('ch_usid') or @setCookie('ch_usid', @user_uid, 365))
    console.log "Set from Cookie -> @user_uid :", @user_uid

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

window.cfrm = new window.ChatFrame(window._chcfg)
window.cfrm.load_site_config()
