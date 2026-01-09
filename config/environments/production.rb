require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Reloading & eager load
  config.enable_reloading = false
  config.eager_load = true

  # Errors
  config.consider_all_requests_local = false

  # Caching (SAFE – no DB)
  config.action_controller.perform_caching = true
  config.cache_store = :memory_store

  # Static files cache
  config.public_file_server.headers = {
    "cache-control" => "public, max-age=#{1.year.to_i}"
  }

  # Active Storage (local is OK on free tier)
  config.active_storage.service = :local

  # Background jobs (NO DB REQUIRED)
  config.active_job.queue_adapter = :async

  # Logging
  config.log_tags = [:request_id]
  config.logger = ActiveSupport::TaggedLogging.logger(STDOUT)
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")

  # Silence health check logs
  config.silence_healthcheck_path = "/up"

  # Disable deprecations
  config.active_support.report_deprecations = false

  # Mailer
  config.action_mailer.raise_delivery_errors = false
  config.action_mailer.perform_caching = false
  config.action_mailer.default_url_options = {
    host: ENV.fetch("APP_HOST", "bill-sahuliyat-yvti.onrender.com")
  }

  # I18n
  config.i18n.fallbacks = true

  # DB
  config.active_record.dump_schema_after_migration = false
  config.active_record.attributes_for_inspect = [:id]

  # Security (recommended)
  config.force_ssl = true
end
