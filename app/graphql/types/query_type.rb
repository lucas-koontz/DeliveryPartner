# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Add `node(id: ID!) and `nodes(ids: [ID!]!)`
    include GraphQL::Types::Relay::HasNodeField
    include GraphQL::Types::Relay::HasNodesField

    # Hello World
    field :showHelloWorld, resolver: Queries::ShowHelloWorld

    # Partner
    field :retrievePartner, resolver: Partners::Queries::RetrievePartner
  end
end
