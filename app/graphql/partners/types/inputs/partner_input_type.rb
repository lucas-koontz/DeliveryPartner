# frozen_string_literal: true

module Partners
  module Types
    module Inputs
      class PartnerInputType < ::Types::BaseInputObject
        description 'Partner Input'

        argument :trading_name, String, required: true
        argument :owner_name, String, required: true
        argument :document, String, required: true
        argument :coverage_area, Partners::Types::Inputs::MultiPolygonInputType, required: true
        argument :address, Partners::Types::Inputs::PointInputType, required: true
      end
    end
  end
end
