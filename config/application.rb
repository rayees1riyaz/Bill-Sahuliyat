require_relative "boot"

require "rails"

# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "active_storage/engine"
require "action_mailbox/engine"
require "action_text/engine"
require "action_cable/engine"  

Bundler.require(*Rails.groups)

module BillSahuliyat
  class Application < Rails::Application
    config.load_defaults 8.1

    config.active_job.queue_adapter = :async
    config.cache_store = :memory_store

    config.autoload_lib(ignore: %w[assets tasks])
  end
end
