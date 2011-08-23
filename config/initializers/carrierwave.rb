CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',
    :aws_access_key_id      => 'AKIAI3AHD3GGZJ4TKDVA',
    :aws_secret_access_key  => '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'
  }
  config.fog_directory  = 'autoreminder-company'
end