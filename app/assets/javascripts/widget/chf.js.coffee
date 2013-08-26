class ChatFrame
  constructor: (@options) ->
    console.log('Constructor Start ->')
    console.log('widg opt:', @options)
    @site_uid = @options['widget_id']
    @button_id = '#' + @site_uid
    @widget_window_id = '#chw-' + @site_uid
    @assets_host = 'localhost:3000'
    @chat_config_host = 'localhost:3000'
    @site_config = {id: @site_uid}
    @sheme = 'http'
    @sheme = 'https' if (document.location.protocol is 'https:')
    @site_config_url = @sheme + '://' + @chat_config_host + '/sites/' + @site_uid + '.json'

    @widget_css_url = @sheme + '://localhost:3000/assets/widget.css'
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
    jQuery('body').append(jQuery('<div id="' + @site_uid + '" style="position: absolute; z-index: 10000">Online Help</div>'))
    #jQuery('body').append(window.ch_button)
    @style_button(jQuery(@button_id))
    self = @
    if @site_config['auto_open'] is '1'
      self.load_css()
      self.show_widget()

    jQuery(@button_id).on 'click', (event) ->
      div = event.target
      console.log 'Click on div', div

      if jQuery(@widget_window_id).length() != 1
        self.load_css()
        self.show_widget()
      else
        self.toggle_widget()

  load_css: ->
    console.log 'load_css ->'
    css = document.createElement("link")
    css.media = "all"
    css.rel = 'stylesheet'
    css.href = @widget_css_url
    document.body.appendChild(css)

  toggle_widget: ->
    console.log 'toggle_widget ->'
    jQuery(@widget_window_id).toggle()
    jQuery(@button_id).toggle()

  style_button: (element)->
    console.log('Styled button ->' + element.attr('id'))
    element.css('background-color', @site_config['color'])
    element.css('box-shadow', '0 3px 8px rgba(50, 50, 50, 0.17)')
    element.css('border', '1px solid ' + @site_config['color'])
    @position(element)

  position: (element) ->
    console.log 'position ->', element.attr('id')
    element.css(@site_config['side'], 0)
    if @site_config['position'] is 'center'
      element.css('left', (jQuery(window).width() / 2) - (jQuery(element).width() / 2))
    else
      element.css(@site_config['position'], 0)

  show_widget: ->
    console.log 'show_widget ->'
    jQuery('body').append(_.template(window.ch_widget_tpl, { config: @site_config }))
    @position(jQuery(@widget_window_id))
    @bind_widget_events()

  bind_widget_events: ->
    console.log 'bind events ->'
    jQuery('.chf_ico_close').on 'click', (event) ->
      close_widget()
    jQuery('.chf_ico_popup').on 'click', (event)->
      @popup_widget()
    jQuery('.chf_ico_hide').on 'click', (event)->
      @hide_widget()

  popup_widget: ->
    #TODO add wull screen action for widget
    alert('TODO popup')
  close_widget: ->
    jQuery(@widget_window_id).hide()
  hide_widget: ->
    jQuery(@widget_window_id).hide()

cfrm = new ChatFrame(window._shcp)
cfrm.load_site_config()


#  jquery_load: ->
#    el = document.createElement("script")
#    el.type = "text/javascript"
#    el.setAttribute("charset", "UTF-8");
#    el.async = 'false'
#    el.src = jQuery_load_path
#    self = @
#    el.onload = () ->
#      self.load_site_config(self.site_config_url)
#
#    document.body.appendChild(el)

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