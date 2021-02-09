# frozen_string_literal: true

require 'rails_helper'
require 'support/graphql_helpers'

RSpec.describe Queries::ShowHelloWorld do
  describe 'type' do
    it {
      expect(described_class.type).to eq Types::HelloWorldType
    }
  end

  describe 'arguments' do
    it { expect(described_class.arguments['name'].type.to_type_signature).to eq 'String!' }
  end

  it 'returns a message ' do
    query_string = <<-QUERY
      query {
        showHelloWorld(name: "Harry Potter") {
          message
        }
      }
    QUERY

    query_result = DeliveryPartnerSchema.execute(query_string)
    response = graphql_response(query_result)

    expect(response).to match(
      data: {
        showHelloWorld: {
          message: 'Hello there Harry Potter'
        }
      }
    )
  end
end
