# frozen_string_literal: true

module GraphqlHelpers
  def graphql_response(response)
    response.to_h.deep_symbolize_keys
  end
end
