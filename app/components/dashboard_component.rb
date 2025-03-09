# frozen_string_literal: true

class DashboardComponent < ViewComponent::Base
  attr_reader :hive

  def initialize(hive:)
    super

    @hive = hive
  end
end
