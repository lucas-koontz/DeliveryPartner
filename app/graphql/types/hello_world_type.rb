# frozen_string_literal: true

module Types
  class HelloWorldType < Types::BaseObject
    description 'Hello World'

    field :message, String, null: false
  end
end
