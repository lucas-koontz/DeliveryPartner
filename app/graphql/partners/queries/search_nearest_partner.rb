# frozen_string_literal: true

module Partners
  module Queries
    class SearchNearestPartner < ::Queries::BaseQuery
      description 'Search nearest partner'

      type Partners::Types::PartnerType, null: true

      argument :lat, Float, required: true
      argument :long, Float, required: true

      def resolve(lat:, long:)
        Partners::SearchNearestPartnerService.call(latitude: lat, longitude: long)
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new('Partner not found.')
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
