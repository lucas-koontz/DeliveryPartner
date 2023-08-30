# frozen_string_literal: true

module Partners
  class SearchNearestPartnerService < ::BaseService
    attr_reader :latitude, :longitude

    def initialize(latitude:, longitude:)
      super()
      @latitude = latitude
      @longitude = longitude
    end

    def call
      containing_partners = Partner.select(
        "(ST_DISTANCE(address, ST_GeographyFromText('#{point}'))) AS distance", '*'
      )
                                   .where("ST_Intersects(coverage_area, '#{point}')")
                                   .order('distance ASC')

      partner = containing_partners.first

      raise ActiveRecord::RecordNotFound, 'Unable to find a partner in that area.' if partner.blank?

      output(PartnerSerializer.new(partner))
    end

    private

    def point
      hash_point = {
        type: 'Point',
        coordinates: [longitude, latitude] # GeoJSON inverts it order
      }
      GeoJsonHelper.decode(json: hash_point.to_json)
    end
  end
end
