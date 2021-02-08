# frozen_string_literal: true

module Partners
  module Mutations
    class CreatePartner < ::Mutations::BaseMutation
      description 'Creates a new parnter'

      argument :partner, Partners::Types::Inputs::PartnerInputType, required: true

      field :partner, Partners::Types::PartnerType, null: false

      def resolve(partner:)
        params = Hash partner
        params[:id] = 1

        { partner: params }
      end
    end
  end
end
