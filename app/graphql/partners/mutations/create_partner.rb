# frozen_string_literal: true

module Partners
  module Mutations
    class CreatePartner < ::Mutations::BaseMutation
      description 'Creates a new parnter'

      argument :partner, Partners::Types::Inputs::PartnerInputType, required: true

      field :partner, Partners::Types::PartnerType, null: false

      def resolve(**args)
        payload = Hash args[:partner]

        Partners::CreatePartnerService.call(payload: payload)
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new("Invalid attributes for #{e.record.class}: " \
                                    "#{e.record.errors.full_messages.join(', ')}")
      rescue Partners::Errors::InvalidGeographicalFeatureError => e
        GraphQL::ExecutionError.new("Invalid Geographic Feature: #{e.message}")
      end
    end
  end
end
