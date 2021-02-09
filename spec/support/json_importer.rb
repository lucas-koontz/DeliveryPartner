# frozen_string_literal: true

module JsonImporter
  class << self
    def import_fixture(name)
      JSON.parse(File.read(Rails.root.join('spec', 'fixtures', name))).deep_symbolize_keys
    end
  end
end
