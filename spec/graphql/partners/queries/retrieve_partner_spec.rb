# frozen_string_literal: true

require 'rails_helper'
require 'support/graphql_helpers'

RSpec.describe Partners::Queries::RetrievePartner do
  describe 'type' do
    it {
      expect(described_class.type).to eq Partners::Types::PartnerType
    }
  end

  describe 'arguments' do
    it { expect(described_class.arguments['id'].type.to_type_signature).to eq 'ID!' }
  end

  describe '#resolve' do
    let(:id) { '1' }

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
          coordinates: [-46.57421, -21.785741]
        }
      }
    end

    let(:service_reponse) { OpenStruct.new(partner_payload) }

    let(:data) do
      {
        retrievePartner: {
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
            coordinates: [-46.57421, -21.785741]
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
            retrievePartner(id: "#{id}") {
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
      allow(Partners::RetrievePartnerService).to receive(:call)
        .with(id: id)
        .and_return(service_reponse)
    end

    it 'returns a  partner' do
      query_result = DeliveryPartnerSchema.execute(query_string)
      response = graphql_response(query_result)
      expect(response).to eq(query_response)
    end
  end
end
