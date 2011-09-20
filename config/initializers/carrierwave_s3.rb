CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => 'AKIAIJRIUCWCZVN3ZW5A',       # required
    :aws_secret_access_key  => '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',       # required
    :region                 => 'eu-west-1'  # optional, defaults to 'us-east-1'
  }
  config.fog_directory  = 'mysenso'                     # required
end
