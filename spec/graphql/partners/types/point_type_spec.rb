# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Types::PointType do
  subject { DeliveryPartnerSchema.types['Point'] }

  describe 'fields' do
    it { is_expected.to have_field(:type).of_type('PointEnum!') }
    it { is_expected.to have_field(:coordinates).of_type('Coordinate!') }
  end
end
