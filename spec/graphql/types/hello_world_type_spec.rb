# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::HelloWorldType do
  subject { DeliveryPartnerSchema.types['HelloWorld'] }

  describe 'fields' do
    it { is_expected.to have_field(:message).of_type('String!') }
  end
end
