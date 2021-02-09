# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Types::Inputs::MultiPolygonInputType do
  describe 'arguments' do
    let(:arguments) { described_class.arguments }

    it {
      expect(arguments['type'].type.to_type_signature).to eq 'String!'
      expect(arguments['coordinates'].type.to_type_signature).to eq '[[[Coordinate!]!]!]!'
    }
  end
end
