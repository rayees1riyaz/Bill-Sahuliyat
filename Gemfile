source "https://rubygems.org"

# Rails
gem "rails", "~> 8.1.1"

# Asset pipeline
gem "propshaft"

# Web server
gem "puma", ">= 5.0"

# Frontend (Hotwire)
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "devise"

# APIs
gem "jbuilder"

# Database
# SQLite only for development & test
gem "sqlite3", group: [:development, :test]

# MySQL only for production (and development based on database.yml)
group :production, :development do
  gem "mysql2", "~> 0.5"
end

# Timezone data for Windows
gem "tzinfo-data", platforms: %i[windows jruby]

# Solid adapters (Rails 8 defaults)
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Faster boot time
gem "bootsnap", require: false

# Deployment tools (optional)
gem "kamal", require: false
gem "thruster", require: false

# Image processing
gem "image_processing", "~> 1.2"

# QR code generation
gem "rqrcode"

# PDF generation
gem "grover"

# --------------------
# Development & Test
# --------------------
group :development, :test do
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"
  gem "bundler-audit", require: false
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "letter_opener"
end

# Development only
group :development do
  gem "web-console"
end

# Test only
group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
