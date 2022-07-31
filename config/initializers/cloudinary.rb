# frozen_string_literal: true

Cloudinary.config do |config|
  config.cloud_name = Rails.application.credentials.dig(:cloudinary, :cloud_name)
  config.api_key = Rails.application.credentials.dig(:cloudinary, :api_key)
  config.api_secret =  Rails.application.credentials.dig(:cloudinary, :api_secret)
  config.cdn_subdomain = Rails.application.credentials.dig(:cloudinary, :cdn_subdomain)
end
