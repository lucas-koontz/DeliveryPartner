# frozen_string_literal: true

module Queries
  class ShowHelloWorld < Queries::BaseQuery
    type Types::HelloWorldType, null: true

    argument :name, String, required: true

    def resolve(**args)
      OpenStruct.new(message: "Hello there #{args[:name]}")
    end
  end
end
