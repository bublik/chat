class window.ChatFrame
  constructor: (@options) ->
    console.log('Constructor Start ->')
    console.log('widg opt:', @options)
    @site_uid = @options['widget_id']
    @button_id = '#btn-' + @site_uid
    @widget_window_id = '#widg-' + @site_uid
    @assets_host = 'localhost:3000'
    @chat_config_host = 'localhost:3000'
    @site_config = {id: @site_uid}
    @sheme = 'http'
    @sheme = 'https' if (document.location.protocol is 'https:')

    @widget_css_url = @sheme + '://localhost:3000/assets/widget.css'
    @lang = (navigator.language || navigator.userLanguage || navigator.systemLanguage || "en").substr(0, 2).toLowerCase()
    @site_config_url = @sheme + '://' + @chat_config_host + '/sites/' + @site_uid + '.json?lang=' + @lang
    console.log('Constructor Finis \<-')

  load_site_config: ->
    console.log 'load_site_config ->'
    self = @
    jQuery.getJSON @site_config_url, (data) ->
      _.extend(self.site_config, data)
      console.log 'Config LOADED!!! ->', self.site_config
      self.init_button()

  init_button: ->
    console.log 'init button ->', @button_id
    if @site_config['disabled'] is '1'
      console.log 'widget disabled!'
    jQuery('body').append(_.template(window.ch_button, { btn: @site_config }))

    #@style_button(jQuery(@button_id))
    self = @
    if @site_config['auto_open'] is '1'
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

#  style_button: (_el) ->
#    console.log('Styled button ->' + _el.attr('id'))
#    _el.css('background-color', @site_config['color'])
#    _el.css('box-shadow', '0 3px 8px rgba(50, 50, 50, 0.17)')
#    _el.css('border', '1px solid ' + @site_config['color'])
#    #@position(_el)

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
    jQuery('.chf_ico_close').on 'click', (e) ->
      self.close_widget()
    jQuery('.chf_ico_popup').on 'click', (e) ->
      self.popup_widget()
    jQuery('.chf_ico_hide').on 'click', (e) ->
      self.hide_widget()
    jQuery('.shf_enter_ico').on 'click', (e) ->
      self.send_message()

  show_widget: ->
    console.log 'show_widget ->', jQuery(@widget_window_id)
    unless jQuery(@widget_window_id)[0]
      @load_css()
      console.log 'Add widget to page'
      jQuery('body').append(_.template(window.ch_widget_tpl, { config: @site_config }))
      @bind_widget_events()

    jQuery(@widget_window_id).fadeIn()
    @position(jQuery(@widget_window_id))

  popup_widget: ->
    #TODO add wull screen action for widget
    alert('TODO popup')
  close_widget: ->
    jQuery(@widget_window_id).hide()
  hide_widget: ->
    jQuery(@widget_window_id).fadeOut() #hide()

  send_message: ->
    text_field = jQuery('.shf_textarea_answer textarea')
    content = text_field.val()
    text_field.val('')
    date = new Date
    gmt_date = date.toGMTString()

    msg = {avatar_path: '/avatar', full_name: 'Full name', content: content, time_at: date.toLocaleString().split(' ')[1]}
    mesage_content =  _.template(window.ch_message_tpl, { msg: msg })
    jQuery(' #shf_messages').append(mesage_content)

cfrm = new window.ChatFrame(window._shcp)
cfrm.load_site_config()













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