# frozen_string_literal: true

module Partners
  module Types
    module Inputs
      class PointInputType < ::Types::BaseInputObject
        description 'Geographic Point Input'

        argument :type, String, required: true
        argument :coordinates, Types::CoordinateType, required: true
      end
    end
  end
end
