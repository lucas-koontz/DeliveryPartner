# frozen_string_literal: true

module Partners
  module Types
    class PartnerType < ::Types::BaseObject
      description 'Partner entity'

      field :id, ID, null: false
      field :trading_name, String, null: false
      field :owner_name, String, null: false
      field :document, String, null: false
      field :coverage_area, Types::MultiPolygonType, null: false
      field :address, Types::PointType, null: false
    end
  end
end
