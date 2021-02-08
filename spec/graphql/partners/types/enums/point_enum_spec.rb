# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partners::Types::Enums::PointEnum do
  describe 'values' do
    let(:enum) { described_class.graphql_definition }

    it 'has value point' do
      expect(enum.coerce_isolated_input('Point')).to eq 'Point'
    end
  end
end
