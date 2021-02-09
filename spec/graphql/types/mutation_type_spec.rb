# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Types::MutationType do
  subject { DeliveryPartnerSchema.types['Mutation'] }

  describe 'fields' do
    it { is_expected.to have_field(:createHelloWorld) }
    it { is_expected.to have_field(:createPartner) }
  end

  describe 'createHelloWorld field' do
    it 'resolves with the right function' do
      resolver = subject.fields['createHelloWorld'].mutation

      expect(resolver).to equal Mutations::CreateHelloWorld
    end
  end

  describe 'createPartner field' do
    it 'resolves with the right function' do
      resolver = subject.fields['createPartner'].mutation

      expect(resolver).to equal Partners::Mutations::CreatePartner
    end
  end
end
