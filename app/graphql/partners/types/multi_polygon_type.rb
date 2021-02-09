# frozen_string_literal: true

module Partners
  module Types
    class MultiPolygonType < ::Types::BaseObject
      description 'Geographic MultiPolygon entity'

      field :type, String, null: false
      field :coordinates, [[[Types::CoordinateType]]], null: false
    end
  end
end
