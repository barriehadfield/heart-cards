# config/initializers/hyperloop.rb
# If you are not using ActionCable, see http://ruby-hyperloop.io/docs/models/configuring-transport/
Hyperloop.configuration do |config|
  config.cancel_import('hyper-router/react-router-source')
  config.compress_system_assets = false
  config.transport = :pusher
  config.channel_prefix = "Hyperloop"
  # config.auto_config = true
  config.opts = {
    app_id: "432445",
    key: "e1ef057dfe6f7903c24f",
    secret: "c457bc4aab3764fa52d2",
    cluster: "mt1"
  }
  config.prerendering = :off
  config.import 'reactrb/auto-import'
end
