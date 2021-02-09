# frozen_string_literal: true

module Partners
  module Queries
    class RetrievePartner < ::Queries::BaseQuery
      description 'Retrieves a parnter'

      type Partners::Types::PartnerType, null: true

      argument :id, ID, required: true

      def resolve(id:)
        Partners::RetrievePartnerService.call(id: id)
      rescue ActiveRecord::RecordNotFound => _e
        GraphQL::ExecutionError.new('Partner does not exist.')
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}:"\
          " #{e.record.errors.full_messages.join(', ')}")
      end
    end
  end
end
