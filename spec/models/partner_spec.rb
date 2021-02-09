# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Partner, type: :model do
  subject(:partner) { create :partner }

  it 'has a valid factory' do
    expect(create(:partner)).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:trading_name) }
    it { should validate_presence_of(:owner_name) }
    it { should validate_presence_of(:document) }
    it { should validate_presence_of(:coverage_area) }
    it { should validate_presence_of(:address) }

    it { should validate_uniqueness_of(:document).case_insensitive }
  end
end
