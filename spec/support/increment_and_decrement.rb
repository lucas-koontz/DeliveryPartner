# frozen_string_literal: true

RSpec::Matchers.alias_matcher :increment, :change do |desc|
  desc.gsub('changed', 'incremented').gsub('change', 'increment')
end

RSpec::Matchers.alias_matcher :decrement, :change do |desc|
  desc.gsub('changed', 'decremented').gsub('change', 'decrement').gsub('-', '')
end

module IncrementAndDecrement
  def increment(*args, &block)
    super(*args, &block).by(1)
  end

  def decrement(*args, &block)
    super(*args, &block).by(-1)
  end
end

RSpec.configure do |config|
  config.include IncrementAndDecrement
end
