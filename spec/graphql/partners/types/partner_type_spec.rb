# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Types::PartnerType do
  subject { DeliveryPartnerSchema.types['Partner'] }

  describe 'fields' do
    it { is_expected.to have_field(:id).of_type('ID!') }
    it { is_expected.to have_field(:tradingName).of_type('String!') }
    it { is_expected.to have_field(:ownerName).of_type('String!') }
    it { is_expected.to have_field(:document).of_type('String!') }
    it { is_expected.to have_field(:coverageArea).of_type('MultiPolygon!') }
    it { is_expected.to have_field(:address).of_type('Point!') }
  end
end
