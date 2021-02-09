# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::CreatePartnerService do
  describe '#call' do
    subject { Partners::CreatePartnerService }

    let(:multi_polygon) do
      {
        type: 'MultiPolygon',
        coordinates: [
          [[[30, 20], [45, 40], [10, 40], [30, 20]]],
          [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
        ]
      }
    end

    let(:point) do
      {
        type: 'Point',
        coordinates: [-46.57421, -21.785741]
      }
    end

    let(:coverage_area) { multi_polygon }

    let(:address) { point }

    let(:payload) do
      {
        trading_name: 'Adega da Cerveja - Pinheiros',
        owner_name: 'Zé da Silva',
        document: '1432132123891/0001',
        coverage_area: coverage_area,
        address: address
      }
    end

    it 'persists a partner' do
      expect do
        subject.call(payload: payload)
      end.to(increment { Partner.count })
    end

    it 'returns a serialized partner' do
      expect(subject.call(payload: payload).partner).to be_an_instance_of(PartnerSerializer)
    end

    context 'validate geographic feature' do
      context 'requires coverage area to be a multi polygon' do
        let(:coverage_area) { point }
        it 'raises InvalidGeographicalFeatureError' do
          expect do
            subject.call(payload: payload)
          end.to raise_error(Partners::Errors::InvalidGeographicalFeatureError)
        end
      end

      context 'requires address to be a point' do
        let(:address) { multi_polygon }
        it 'raises InvalidGeographicalFeatureError' do
          expect do
            subject.call(payload: payload)
          end.to raise_error(Partners::Errors::InvalidGeographicalFeatureError)
        end
      end
    end
  end
end
