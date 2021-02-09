class PartnerSerializer < ActiveModel::Serializer
  attributes :id, :trading_name, :owner_name, :document, :coverage_area, :address

  delegate :id, :trading_name, :owner_name, :document, to: :object

  def coverage_area
    GeoJsonHelper.encode(rgeo_object: object.coverage_area)
  end

  def address
    GeoJsonHelper.encode(rgeo_object: object.address)
  end
end
