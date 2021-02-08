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
    let(:partner) do
      {
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
    end

    let(:mutation_response) do
      {
        data: {
          createPartner: partner
        }
      }
    end

    it 'returns created partner' do
      query_string = <<~MUTATION
              mutation {
                createPartner(
                  input: {#{' '}
                    partner: {
                      tradingName: "Adega da Cerveja - Pinheiros",
                      ownerName: "Zé da Silva",
                      document: "1432132123891/0001",
                    coverageArea: {
                      type: MultiPolygon,
                      coordinates: [
                        [[[30, 20], [45, 40], [10, 40], [30, 20]]],#{' '}
                        [[[15, 5], [40, 10], [10, 20], [5, 10], [15, 5]]]
                      ]
                    },
                    address: {
                      type: Point,
                      coordinates: [-46.57421, -21.785741]
                    }
                  }#{' '}
        #{'        '}
        #{'            '}
                  }) {
                partner {
                  id,
                  tradingName,
                  ownerName,
                  document,
                  address {
                    type,
                    coordinates
                  }
                  coverageArea {
                    type,
                    coordinates
                  }
                }
              }
            }
      MUTATION

      query_result = DeliveryPartnerSchema.execute(query_string)
      response = graphql_response(query_result)
      expect(response).to eq(mutation_response)
    end
  end
end
