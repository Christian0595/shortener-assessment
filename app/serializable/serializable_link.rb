class SerializableLink < JSONAPI::Serializable::Resource
  type 'links'

  attributes :url, :code

  attribute :count do
    @object.visits.count
  end
end
