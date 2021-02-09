# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::RetrievePartnerService do
  describe '#call' do
    subject { Partners::RetrievePartnerService }

    let(:partner) { create(:partner) }

    let(:id) { partner.id }

    let(:serialized_partner) { PartnerSerializer.new(partner) }

    let(:successful_response) { OpenStruct.new(**serialized_partner) }

    it 'retrieves a partner a serialized partner' do
      expect(subject.call(id: id)).to eq(successful_response)
    end
  end
end
