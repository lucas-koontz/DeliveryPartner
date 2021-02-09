# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Types::MultiPolygonType do
  subject { DeliveryPartnerSchema.types['MultiPolygon'] }

  describe 'fields' do
    it { is_expected.to have_field(:type).of_type('String!') }
    it { is_expected.to have_field(:coordinates).of_type('[[[Coordinate!]!]!]!') }
  end
end
