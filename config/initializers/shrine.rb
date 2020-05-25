require 'shrine/storage/s3'

if Rails.env.production?
  s3_options = {
    access_key_id: Rails.application.credentials.digitalocean_spaces_key,
    secret_access_key: Rails.application.credentials.digitalocean_spaces_secret,
    bucket: 'onpax-production-aws',
    endpoint: 'https://sfo2.digitaloceanspaces.com',
    region: 'sfo2'
  }
else
  s3_options = {
    access_key_id: Rails.application.credentials.digitalocean_spaces_key,
    secret_access_key: Rails.application.credentials.digitalocean_spaces_secret,
    bucket: 'onpax-development-aws',
    endpoint: 'https://sfo2.digitaloceanspaces.com',
    region: 'sfo2'
  }
end


Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: {acl: 'public-read'}, **s3_options),
  store: Shrine::Storage::S3.new(prefix: 'store', upload_options: {acl: 'public-read'}, **s3_options)
}

Shrine.plugin :activerecord
Shrine.plugin :validation_helpers
