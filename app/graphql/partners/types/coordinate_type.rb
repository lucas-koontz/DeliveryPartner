# frozen_string_literal: true

module Partners
  module Types
    class CoordinateType < ::Types::BaseScalar
      description 'A valid coordinate [latitude, longitude]'

      def self.coerce_input(input_value, _context)
        unless input_value.count == 2 && input_value.all? do |v|
                 v.is_a?(Numeric)
               end
          raise GraphQL::CoercionError,
                "#{input_value.inspect} is not a valid coordinate"
        end

        input_value
      end

      def self.coerce_result(ruby_value, _context)
        ruby_value
      end
    end
  end
end
