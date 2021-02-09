# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::SearchNearestPartnerService do
  describe '#call' do
    subject { Partners::SearchNearestPartnerService }

    let(:latitude) { -19.887215 }
    let(:longitude) { -44.012478 }

    context 'on success' do
      let(:address) { create_coordinate(latitude: latitude, longitude: longitude) }

      let(:partner) { create(:partner, address: address) }

      let(:serialized_partner) { PartnerSerializer.new(partner) }

      let(:successful_response) { OpenStruct.new(**serialized_partner) }

      before do
        partner
      end

      it 'find a partner in the coverage area' do
        expect(subject.call(latitude: latitude, longitude: longitude)).to eq(successful_response)
      end

      it 'find nearest partner in the coverage area' do
        create(:partner,
               address: create_coordinate(latitude: latitude - 0.001, longitude: longitude))
        create(:partner,
               address: create_coordinate(latitude: latitude, longitude: longitude - 0.001))

        expect(subject.call(latitude: latitude, longitude: longitude)).to eq(successful_response)
      end
    end

    context 'on failure' do
      it 'raises an error when no partner exists' do
        expect do
          subject.call(latitude: latitude, longitude: longitude)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end

      it 'raises an error when a partner exists outside location coverage area' do
        create(:partner)

        expect do
          subject.call(latitude: 0, longitude: 0)
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    def create_coordinate(latitude:, longitude:)
      GeoJsonHelper.decode(json:
        {
          type: 'Point',
          coordinates: [
            longitude,
            latitude
          ]
        }.to_json)
    end
  end
end
