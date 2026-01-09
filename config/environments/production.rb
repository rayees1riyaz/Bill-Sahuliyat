require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Code is not reloaded between requests.
  config.enable_reloading = false

  # Eager load code on boot.
  config.eager_load = true

  # Disable full error reports.
  config.consider_all_requests_local = false

  # Enable caching
  config.action_controller.perform_caching = true

  # Cache static assets
  config.public_file_server.headers = {
    "cache-control" => "public, max-age=#{1.year.to_i}"
  }

  # Active Storage (local is fine on Render free)
  config.active_storage.service = :local

  # Logging
  config.log_tags = [:request_id]
  config.logger   = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Silence healthcheck logs
  config.silence_healthcheck_path = "/up"

  # Disable deprecation logs
  config.active_support.report_deprecations = false

  # ✅ SAFE CACHE FOR RENDER FREE
  config.cache_store = :memory_store

  # ✅ SAFE BACKGROUND JOBS (NO DB REQUIRED)
  config.active_job.queue_adapter = :async

  # Mailer settings (no email errors in prod)
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = {
    host: ENV.fetch("APP_HOST", "bill-sahuliyat-yvti.onrender.com")
  }

  # I18n fallback
  config.i18n.fallbacks = true

  # Do not dump schema after migrations
  config.active_record.dump_schema_after_migration = false

  # Short inspect output
  config.active_record.attributes_for_inspect = [:id]
end
