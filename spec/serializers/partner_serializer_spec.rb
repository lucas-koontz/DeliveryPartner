# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PartnerSerializer, type: :serializer do
  let(:partner) { create(:partner) }

  subject { PartnerSerializer.new(partner) }

  describe 'serializes a partner' do
    it { expect(subject.id).to eq(partner.id) }
    it { expect(subject.trading_name).to eq(partner.trading_name) }
    it { expect(subject.owner_name).to eq(partner.owner_name) }
    it { expect(subject.document).to eq(partner.document) }
    it {
      expect(subject.coverage_area).to eq(GeoJsonHelper.encode(rgeo_object: partner.coverage_area))
    }
    it { expect(subject.address).to eq(GeoJsonHelper.encode(rgeo_object: partner.address)) }
  end
end
