# frozen_string_literal: true

class Partner < ApplicationRecord
  validates :trading_name, :owner_name, :document, :coverage_area, :address, presence: true
  validates :document, uniqueness: true
end
