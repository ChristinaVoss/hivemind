# frozen_string_literal: true

class DashboardComponent < ViewComponent::Base
  attr_reader :hive

  def initialize(hive:)
    @hive = hive
  end
end
