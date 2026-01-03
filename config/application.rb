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

# ❌ IMPORTANT:
# Do NOT require "action_cable/engine"
# This completely disables ActionCable & SolidCable

# Require the gems listed in Gemfile
Bundler.require(*Rails.groups)

module BillSahuliyat
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.1

    # ✅ Safe defaults for simple apps (billing / CRUD)
    config.active_job.queue_adapter = :async
    config.cache_store = :memory_store

    # Disable ActionCable completely
    config.action_cable.mount_path = nil

    # Autoload lib, ignoring non-ruby dirs
    config.autoload_lib(ignore: %w[assets tasks])
  end
end
