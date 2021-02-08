# frozen_string_literal: true

module Partners
  module Types
    module Inputs
      class MultiPolygonInputType < ::Types::BaseInputObject
        description 'Geographic MultiPolygon Input'

        argument :type, Types::Enums::MultiPolygonEnum, required: true
        argument :coordinates, [[[Types::CoordinateType]]], required: true
      end
    end
  end
end
