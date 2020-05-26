require 'shrine/storage/s3'

if Rails.env.production?
  s3_options = {
    access_key_id: "",
    secret_access_key: "",
    bucket: '',
    endpoint: '',
    region: ''
  }
else
  s3_options = {
    access_key_id: "",
    secret_access_key: "",
    bucket: '',
    endpoint: '',
    region: ''
  }
end


Shrine.storages = {
  cache: Shrine::Storage::S3.new(prefix: 'cache', upload_options: {acl: 'public-read'}, **s3_options),
  store: Shrine::Storage::S3.new(prefix: 'store', upload_options: {acl: 'public-read'}, **s3_options)
}

Shrine.plugin :activerecord
Shrine.plugin :validation_helpers
