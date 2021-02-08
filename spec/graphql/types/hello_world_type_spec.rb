# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::HelloWorldType do
  describe 'fields' do
    subject { DeliveryPartnerSchema.types['HelloWorld'] }

    it { should have_a_field('message').of_type('String!') }
  end
end
