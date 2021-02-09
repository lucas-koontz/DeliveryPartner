# frozen_string_literal: true

require 'rails_helper'
require 'support/graphql_helpers'

RSpec.describe Mutations::CreateHelloWorld do
  it 'returns a message' do
    mutation_string = <<-MUTATION
      mutation {
        createHelloWorld(input: { name: "Harry Potter" }) {
          message
        }
      }
    MUTATION

    mutation_result = DeliveryPartnerSchema.execute(mutation_string)
    response = graphql_response(mutation_result)

    expect(response).to match(
      data: {
        createHelloWorld: {
          message: 'Congratulations Harry Potter, you did it!'
        }
      }
    )
  end
end
