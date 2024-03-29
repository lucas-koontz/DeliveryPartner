# frozen_string_literal: true

module Partners
  module Types
    class PointType < ::Types::BaseObject
      description 'Geographic Point entity'

      field :type, String, null: false
      field :coordinates, Types::CoordinateType, null: false
    end
  end
end
