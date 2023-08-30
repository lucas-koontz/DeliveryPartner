# frozen_string_literal: true

module JsonImporter
  class << self
    def import_fixture(name)
      JSON.parse(Rails.root.join('spec', 'fixtures', name).read).deep_symbolize_keys
    end
  end
end
