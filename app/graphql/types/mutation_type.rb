# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Hello World
    field :create_hello_world, mutation: Mutations::CreateHelloWorld

    # Partner
    field :create_partner, mutation: Partners::Mutations::CreatePartner
  end
end
