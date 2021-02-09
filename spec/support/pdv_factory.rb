# frozen_string_literal: true

module PdvFactory
  class << self
    PDV_FILE = 'pdvs.json'

    def coverage_area
      import.sample[:coverage_area]
    end

    def address
      import.sample[:address]
    end

    private

    def import
      @import ||= JsonImporter.import_fixture(PDV_FILE)[:pdvs]
    end
  end
end
