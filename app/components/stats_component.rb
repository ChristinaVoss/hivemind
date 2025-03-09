# frozen_string_literal: true

class StatsComponent < ViewComponent::Base
  attr_reader :description, :value, :stats_id

  def initialize(description:, value:, stats_id: nil)
    @description = description
    @value = value
    @stats_id = stats_id
  end
end
