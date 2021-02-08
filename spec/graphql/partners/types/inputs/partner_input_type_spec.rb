# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Types::Inputs::PartnerInputType do
  describe 'arguments' do
    let(:arguments) { described_class.arguments }

    it {
      expect(arguments['tradingName'].type.to_type_signature).to eq 'String!'
      expect(arguments['ownerName'].type.to_type_signature).to eq 'String!'
      expect(arguments['document'].type.to_type_signature).to eq 'String!'
      expect(arguments['coverageArea'].type.to_type_signature).to eq 'MultiPolygonInput!'
      expect(arguments['address'].type.to_type_signature).to eq 'PointInput!'
    }
  end
end
