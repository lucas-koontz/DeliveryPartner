# frozen_string_literal: true

require 'rails_helper'
require 'support/graphql_helpers'

RSpec.describe Partners::Queries::SearchNearestPartner do
  describe 'type' do
    it {
      expect(described_class.type).to eq Partners::Types::PartnerType
    }
  end

  describe 'arguments' do
    it { expect(described_class.arguments['lat'].type.to_type_signature).to eq 'Float!' }
    it { expect(described_class.arguments['long'].type.to_type_signature).to eq 'Float!' }
  end

  describe '#resolve' do
    let(:id) { '1' }

    let(:latitude) { -21.785741 }
    let(:longitude) { -46.57421 }

    let(:partner_payload) do
      {
        id: id,
        trading_name: 'Adega da Cerveja - Pinheiros',
        owner_name: 'Zé da Silva',
        document: '1432132123891/0001',
        coverage_area: {
          type: 'MultiPolygon',
          coordinates: [
            [[[30, 20], [45, 40], [10, 40], [30, 20]]],
            [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
          ]
        },
        address: {
          type: 'Point',
          coordinates: [longitude, latitude]
        }
      }
    end

    let(:service_reponse) { OpenStruct.new(partner_payload) }

    let(:data) do
      {
        searchNearestPartner: {
          id: id,
          tradingName: 'Adega da Cerveja - Pinheiros',
          ownerName: 'Zé da Silva',
          document: '1432132123891/0001',
          coverageArea: {
            type: 'MultiPolygon',
            coordinates: [
              [[[30, 20], [45, 40], [10, 40], [30, 20]]],
              [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
            ]
          },
          address: {
            type: 'Point',
            coordinates: [longitude, latitude]
          }

        }
      }
    end

    let(:query_response) do
      {
        data: data
      }
    end

    let(:query_string) do
      <<-QUERY
          query {
            searchNearestPartner(lat: #{latitude}, long: #{longitude}) {
              id
              tradingName
              ownerName
              document
              coverageArea {
                type
                coordinates
              }
              address {
                type
                coordinates
              }
            }
          }
      QUERY
    end

    before do
      allow(Partners::SearchNearestPartnerService).to receive(:call)
        .with(latitude: latitude, longitude: longitude)
        .and_return(service_reponse)
    end

    it 'returns the nearest partner in the coverage area' do
      query_result = DeliveryPartnerSchema.execute(query_string)
      response = graphql_response(query_result)
      expect(response).to eq(query_response)
    end

    context 'failure' do
      describe 'record not found' do
        before do
          allow(Partners::SearchNearestPartnerService).to receive(:call)
            .with(latitude: latitude, longitude: longitude)
            .and_raise(ActiveRecord::RecordNotFound)
        end

        it 'returns a not found error' do
          expect(GraphQL::ExecutionError).to receive(:new).once.and_call_original

          query_result = DeliveryPartnerSchema.execute(query_string)
          response = graphql_response(query_result)

          expect(response[:errors]).to be_truthy
        end
      end
    end
  end
end
