# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GeoJsonHelper do
  subject { GeoJsonHelper }

  let(:lenient_assertions) { 'true' }

  let(:point) do
    {
      type: 'Point',
      coordinates: [
        -46.693768,
        -23.569365
      ]
    }
  end

  let(:multi_polygon) do
    {
      type: 'MultiPolygon',
      coordinates: [
        [
          [
            [
              -43.36556,
              -22.99669
            ],
            [
              -43.26583,
              -23.01802
            ],
            [
              -43.33427,
              -22.96402
            ],
            [
              -43.36556,
              -22.99669
            ]
          ]
        ]
      ]
    }
  end

  let(:multi_polygon_overlay) do
    {
      type: 'MultiPolygon',
      coordinates: [
        [
          [
            [
              -38.59023,
              -3.75799
            ],
            [
              -38.52955,
              -3.76631
            ],
            [
              -38.53093,
              -3.76639
            ],
            [
              -38.51856,
              -3.76537
            ],
            [
              -38.55554,
              -3.7091
            ],
            [
              -38.56165,
              -3.70747
            ],
            [
              -38.59023,
              -3.75799
            ]
          ]
        ]
      ]
    }
  end

  describe '.decode' do
    context 'decoding a point' do
      it 'returns a geographic point' do
        expect(
          subject.decode(json: point.to_json)
        ).to be_an_instance_of(RGeo::Geographic::SphericalPointImpl)
      end
    end

    context 'deconding a multi polygon' do
      it 'returns a geographic polygon' do
        expect(
          subject.decode(json: multi_polygon.to_json)
        ).to be_an_instance_of(RGeo::Geographic::SphericalMultiPolygonImpl)
      end

      context 'has overlay' do
        it 'returns a geographic polygon' do
          expect(
            subject.decode(json: multi_polygon_overlay.to_json)
          ).to be_an_instance_of(RGeo::Geographic::SphericalMultiPolygonImpl)
        end
      end
    end
  end
end
