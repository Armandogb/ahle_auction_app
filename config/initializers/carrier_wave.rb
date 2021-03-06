require 'carrierwave/orm/activerecord'

CarrierWave.configure do |config|

  config.fog_credentials = {
      provider:              'AWS',                            # required
      aws_access_key_id:     ENV["AWS_ACCESS_KEY"],            # required
      aws_secret_access_key: ENV["AWS_SECRET_KEY"],            # required
      region:                'us-east-1'

  }
  config.fog_directory = ENV["AWS_BUCKET"]                   # required
  config.fog_public    = true
  config.storage       = :fog

end