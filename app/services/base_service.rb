# frozen_string_literal: true

class BaseService
  def self.call(*args)
    new(*args).call
  end

  def output(payload)
    OpenStruct.new(**payload)
  end
end
