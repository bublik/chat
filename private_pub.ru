# Run with: rackup private_pub.ru -s thin -E production
require "bundler/setup"
require "faye"
require "private_pub"
require "yaml"
require 'logger'

log = Logger.new(STDOUT)
log.level = Logger::DEBUG

Faye::WebSocket.load_adapter('thin')
log.debug ENV.inspect
PrivatePub.load_config(File.expand_path("../config/private_pub.yml", __FILE__), ENV["RAILS_ENV"] || ENV["RACK_ENV"] || "development")
bayeux = PrivatePub.faye_app

bayeux.bind(:handshake) do |client_id|
  # Triggered when a new client connects and is issued with an ID.
  log.info "Client #{client_id} Handshake <-"
end

bayeux.bind(:subscribe) do |client_id, channel|
  # Triggered when a client subscribes to a channel.
  # This does not fire if a /meta/subscribe message is received for a subscription that already exists.
  log.info "Client #{client_id} Subscribe [#{channel}]<-"
end

bayeux.bind(:unsubscribe) do |client_id, channel|
  # Triggered when a client unsubscribes from a channel.
  # This can fire either because the client explicitly sent a /meta/unsubscribe message,
  # or because its session was timed out by the server.
  log.info "Client #{client_id} UnSubscribe [#{channel}]<-"
end

bayeux.bind(:publish) do |client_id, channel, data|
  # Triggered when a non-/meta/** message is published.
  # Includes the client ID of the publisher (which may be nil), the channel the message was sent to and the data payload.
  log.info "Client #{client_id} Publish [#{channel}] : #{data}"
end

bayeux.bind(:disconnect) do |client_id|
  # Triggered when a client session ends, either because it explicitly sent a /meta/disconnect message
  # or because its session was timed out by the server.
  log.info "Client #{client_id} Disconnected <-"
end
#bayeux.listen(443,
#              :key  => 'path/to/ssl.key',
#              :cert => 'path/to/ssl.cert'
#)
#bayeux.listen(9292)
run bayeux