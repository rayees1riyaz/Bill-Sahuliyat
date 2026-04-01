source "https://rubygems.org"

ruby "3.3.10"

# Rails
gem "rails", "~> 8.1.2"

# Asset pipeline
gem "propshaft"

# Web server
gem "puma", ">= 5.0"

# Frontend (Hotwire)
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"

# Authentication
gem "devise"

# APIs
gem "jbuilder"

# --------------------
# Database
# --------------------

group :development, :test do
  gem "sqlite3"
end

group :production do
  gem "pg"
end

# --------------------
# Other gems
# --------------------

gem "kaminari"
gem "tzinfo-data", platforms: %i[windows jruby]


# gem "solid_cache"
# gem "solid_queue"
# gem "solid_cable"

# Faster boot time
gem "bootsnap", require: false

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

group :development do
  gem "web-console"
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end
