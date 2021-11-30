class SerializableLink < JSONAPI::Serializable::Resource
  type 'links'

  attributes :url, :code

  attribute :count do
    @object.visits.count
  end

  attribute :short_url do
    "#{ENV['HOSTNAME']}#{@object.code}"
  end
end
