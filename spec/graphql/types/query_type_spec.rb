# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::QueryType do
  subject { DeliveryPartnerSchema.types['Query'] }

  describe 'fields' do
    it { is_expected.to have_field(:showHelloWorld).of_type('HelloWorld') }
    it { is_expected.to have_field(:retrievePartner).of_type('Partner') }
  end
end
