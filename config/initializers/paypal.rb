PayPal::Recurring.configure do |config|
  config.sandbox = true
  config.username = APP_CONFIG['paypal']['username']
  config.password = APP_CONFIG['paypal']['password']
  config.signature = APP_CONFIG['paypal']['signature']
end