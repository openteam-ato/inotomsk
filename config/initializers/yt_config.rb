Yt.configure do |config|
  config.api_key = Settings['youtube.api_key']
  config.log_level = :debug if Rails.env.development?
end
