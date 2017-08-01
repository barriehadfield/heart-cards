# config/initializers/hyperloop.rb
# If you are not using ActionCable, see http://ruby-hyperloop.io/docs/models/configuring-transport/
Hyperloop.configuration do |config|
  # config.import 'client_and_server'
  config.compress_system_assets = false
  config.transport = :action_cable
  config.prerendering = :off
  config.import 'reactrb/auto-import'
end
