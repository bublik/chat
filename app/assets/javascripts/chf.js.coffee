class ChatFrame
  constructor: (@options) ->
    console.log('Widget Initilize!!')
    console.log(@options)
    @site_uid = @options['widget_id']
    @button_id = '#' + @site_uid
    @assets_host = 'localhost:3000'
    @chat_config_host = 'localhost:3000'
    @site_config = {}
    @jquery = null
    @sheme = 'http'
    @sheme = 'https' if (document.location.protocol is 'https:')

    @jquery_load_path = @sheme + '://' + @assets_host + '/assets/jquery-1.10.2.min.js'
    @site_config_url = @sheme + '://' + @chat_config_host + '/sites/' + @site_uid + '.json'
    @chat_url = @sheme + '://localhost:3000/sites/' + @site_uid

    console.log('FINISH constructor')

  jquery_load: ->
    el = document.createElement("script")
    el.type = "text/javascript"
    el.setAttribute("charset", "UTF-8");
    el.async = 'false'
    el.src = @jquery_load_path
    self = @
    el.onload = () ->
      self.load_site_config(self.site_config_url)

    document.body.appendChild(el)

  load_site_config: (url) ->
    console.log('->', url)
    self = @
    if (window.jQuery)
      @jquery = window.jQuery
      console.log 'load_site_config ->', url
      console.log('load_site_config -> jQuery loaded', window.jQuery().jquery)
      window.jQuery.getJSON url, (data) ->
        self.site_config = data
        console.log 'JSON config1 ->', self.site_config
        if data['disabled'] is '1'
          console.log 'widget disabled!'
        else
          self.init_button()

  init_button: ->
    console.log 'init button', @button_id
    #TODO replace to jquery adding chat button div
    el = document.createElement("div")
    el.id = @site_uid
    el.style.position = 'absolute'
    el.style.position = 'z-index: 10000'

    el.appendChild(document.createTextNode('OnlineHelp'))
    document.body.appendChild(el)
    console.log document.getElementById(@site_uid)

    @style_button(@jquery(@button_id))
    self = @
    @jquery(@button_id).on 'click', (event) ->
      div = event.target
      console.log 'Click on div', div

      unless self.widget_element()
        self.create_widget()
      else
        console.log 'Toggle button'

  toggle_buton: ->
    conole.log 'TODO TOGGLE button'

  style_button: (element)->
    config = @site_config
    console.log('#' + element.attr('id'))
    element.css('background-color', config['color'])
    console.log config['position'], config['side']
    element.css(config['side'], 0)
    element.css('box-shadow', '0 3px 8px rgba(50, 50, 50, 0.17)')
    element.css('border', '1px solid '+ config['color'])
    element.css('border-radius', '4px')

    if config['position'] is 'center'
      element.css('left', (@jquery(window).width() / 2) - (@jquery(element).width() / 2))
    else
      element.css(config['position'], 0)

  widget_element: ->
    @jquery('#chf_iframe')[0]
  create_widget: ->
    # added frame
    console.log 'Create chat frame'
    iframe = document.createElement('iframe')
    iframe.src = @chat_url
    iframe.name = 'eg_iframe'
    iframe.id = 'chf_iframe'
    iframe.scrolling = 'yes'
    iframe.frameborder = 'no'
    iframe.framespacing = 0
    iframe.border = 0

    iframe.style.width = "100%"
    iframe.style.height = "100%"
    iframe.style.border = "0"

    document.getElementById(@site_uid).appendChild(iframe)

#    iframeDocument = iframe.contentDocument or iframe.contentWindow.document
#    iframeDocument.open()
#    iframeDocument.write('<!doctype html><html><body><script src=' + @chat_url() + ' ><\/script><\/body><\/html>')
#    iframeDocument.close()

cfrm = new ChatFrame(window._shcp)
cfrm.jquery_load()
