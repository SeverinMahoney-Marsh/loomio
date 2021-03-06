Loomio::Application.configure do
  config.action_dispatch.tld_length = (ENV['TLD_LENGTH'] || 1).to_i

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  config.static_cache_control = 'public, max-age=31536000'

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true
  config.assets.enabled = true

  config.eager_load = true
  
  config.action_dispatch.x_sendfile_header = nil

  # Defaults to Rails.root.join("public/assets")
  # config.assets.manifest = YOUR_PATH

  # Force all access to the app over SSL, use Strict-Transport-Security, and use secure cookies.
  config.force_ssl = true

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Enable serving of images, stylesheets, and JavaScripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Precompile additional assets (application.js, application.css, and all non-JS/CSS are already added)
  # config.assets.precompile += %w( search.js )

  # Enable threaded mode
  # config.threadsafe!

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  if ENV['ENABLE_STAGING_EMAILS']
    # Send emails using SMTP service
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
      :address        => ENV['SMTP_SERVER'],
      :port           => ENV['SMTP_PORT'],
      :authentication => :plain,
      :user_name      => ENV['SMTP_USERNAME'],
      :password       => ENV['SMTP_PASSWORD'],
      :domain         => ENV['SMTP_DOMAIN']
    }
    config.action_mailer.raise_delivery_errors = true
  else
    config.action_mailer.delivery_method = :test
  end

  # Store avatars on Amazon S3
  config.paperclip_defaults = {
    :storage => :fog,
    :fog_credentials => {
      :provider => 'AWS',
      :aws_access_key_id => ENV['AWS_ACCESS_KEY_ID'],
      :aws_secret_access_key => ENV['AWS_SECRET_ACCESS_KEY']
    },
    :fog_directory => ENV['AWS_UPLOADS_BUCKET'],
    :fog_public => true
  }

end
