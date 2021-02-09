# frozen_string_literal: true

module Partners
  class CreatePartnerService < ::BaseService
    attr_reader :payload

    def initialize(payload:)
      @payload = payload
    end

    def call
      validate!

      new_partner = Partner.create!(partner)
      output(partner: PartnerSerializer.new(new_partner))
    end

    private

    def partner
      @partner ||= {
        trading_name: payload[:trading_name],
        owner_name: payload[:owner_name],
        document: payload[:document],
        coverage_area: decode(geo_json: payload[:coverage_area]),
        address: decode(geo_json: payload[:address])
      }
    end

    def decode(geo_json:)
      GeoJsonHelper.decode(json: geo_json.to_json)
    end

    def validate!
      unless partner[:coverage_area].present? &&
             partner[:coverage_area].is_a?(RGeo::Geographic::SphericalMultiPolygonImpl)
        raise Partners::Errors::InvalidGeographicalFeatureError,
              'Coverage area must be a MultiPolygon'
      end
      unless partner[:address].present? &&
             partner[:address].is_a?(RGeo::Geographic::SphericalPointImpl)
        raise Partners::Errors::InvalidGeographicalFeatureError, 'Address must be a point'
      end

      true
    end
  end
end
