# encoding: utf-8

class AdvertisementUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  version :email do
    process :resize_to_fit => [700, 800]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

end
