# frozen_string_literal: true

module GeoJsonHelper
  class << self
    LENIENT_ASSERTIONS = ENV.fetch('LENIENT_ASSERTIONS', true)

    def decode(json:)
      RGeo::GeoJSON.decode(json, geo_factory: factory)
    end

    def encode(rgeo_object:)
      RGeo::GeoJSON.encode(rgeo_object)
    end

    private

    def factory
      @factory ||= RGeo::Geographic.spherical_factory(srid: 4326,
                                                      uses_lenient_assertions: LENIENT_ASSERTIONS)
    end
  end
end
