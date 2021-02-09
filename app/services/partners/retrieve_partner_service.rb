# frozen_string_literal: true

module Partners
  class RetrievePartnerService < ::BaseService
    attr_reader :id

    def initialize(id:)
      super()
      @id = id
    end

    def call
      partner = Partner.find(id)
      output(PartnerSerializer.new(partner))
    end
  end
end
