# frozen_string_literal: true

require 'rails_helper'
require 'support/graphql_helpers'

RSpec.describe Partners::Mutations::CreatePartner do
  describe 'arguments' do
    let(:arguments) { described_class.arguments }

    it {
      expect(arguments['partner'].type.to_type_signature).to eq 'PartnerInput!'
    }
  end

  describe 'fields' do
    let(:fields) { described_class.fields }

    it {
      expect(fields['partner'].type.to_type_signature).to eq 'Partner!'
    }
  end

  describe '#resolve' do
    let(:partner_payload) do
      {
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

    let(:serialized_partner_payload) do
      partner_payload.merge(id: '1')
    end

    let(:service_reponse) { OpenStruct.new(partner: serialized_partner_payload) }

    let(:data) do
      {
        createPartner: {
          partner: {
            id: '1',
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
      }
    end

    let(:mutation_response) do
      {
        data: data
      }
    end

    let(:query_string) do
      <<~MUTATION
          mutation {
            createPartner(
              input: {
                partner: {
                  tradingName: "Adega da Cerveja - Pinheiros",
                  ownerName: "Zé da Silva",
                  document: "1432132123891/0001",
                coverageArea: {
                  type: "MultiPolygon",
                  coordinates: [
                    [[[30, 20], [45, 40], [10, 40], [30, 20]]],
                    [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
                  ]
                },
                address: {
                  type: "Point",
                  coordinates: [-46.57421, -21.785741]
                }
              }
              }) {
            partner {
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
        }
      MUTATION
    end

    before do
      allow(Partners::CreatePartnerService).to receive(:call)
        .with(payload: partner_payload)
        .and_return(service_reponse)
    end

    it 'returns created partner' do
      query_result = DeliveryPartnerSchema.execute(query_string)
      response = graphql_response(query_result)
      expect(response).to eq(mutation_response)
    end

    context 'failure' do
      let(:partner) { create(:partner) }

      describe 'invalid record' do
        before do
          allow(Partners::CreatePartnerService).to receive(:call)
            .with(payload: partner_payload)
            .and_raise(ActiveRecord::RecordInvalid.new(partner))
        end

        it 'returns an invalid attributes error' do
          expect(GraphQL::ExecutionError).to receive(:new).once.and_call_original

          query_result = DeliveryPartnerSchema.execute(query_string)
          response = graphql_response(query_result)

          expect(response[:errors]).to be_truthy
        end
      end
      describe 'invalid geographical feature' do
        before do
          allow(Partners::CreatePartnerService).to receive(:call)
            .with(payload: partner_payload)
            .and_raise(Partners::Errors::InvalidGeographicalFeatureError)
        end

        it 'returns an invalid geograhic feature error' do
          expect(GraphQL::ExecutionError).to receive(:new).once.and_call_original

          query_result = DeliveryPartnerSchema.execute(query_string)
          response = graphql_response(query_result)

          expect(response[:errors]).to be_truthy
        end
      end
    end
  end
end
