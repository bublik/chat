PayPal::Recurring.configure do |config|
  config.sandbox = APP_CONFIG['paypal']['mode'].eql?('sandbox')
  config.username = APP_CONFIG['paypal']['username']
  config.password = APP_CONFIG['paypal']['password']
  config.signature = APP_CONFIG['paypal']['signature']
end