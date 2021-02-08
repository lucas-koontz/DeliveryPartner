# frozen_string_literal: true

module Mutations
  class CreateHelloWorld < ::Mutations::BaseMutation
    type Types::HelloWorldType

    argument :name, String, required: true

    def resolve(**args)
      OpenStruct.new(message: "Congratulations #{args[:name]}, you did it!")
    end
  end
end
