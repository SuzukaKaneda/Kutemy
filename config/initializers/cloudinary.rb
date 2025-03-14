cloudinary_credentials = Rails.application.credentials.dig(:cloudinary)

Cloudinary.config do |config|
  config.cloud_name = "dsxpfm6vs"
  config.api_key = "377435857781197"
  config.api_secret = "wlxztRuJ6TRc5ZKr-hbTWz49I8c"
  config.secure = true
  config.cdn_subdomain = true
end
