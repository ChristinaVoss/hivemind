# frozen_string_literal: true

require "lookbook"

Rails.application.configure do
  # Set paths to our previews
  config.view_component.preview_paths <<
    Rails.root.join("lib/component_previews")
  config.view_component.default_preview_layout = "component_preview"
  # config.view_component.preview_controller = 'ComponentPreviewController'

  # if ENV.fetch('ENABLE_LOOKBOOK', 'false') == 'true'
  #   # Show view component previews if ENABLE_LOOKBOOK is set, otherwise use the
  #   # default setting (i.e. enabled in dev/test environments)
  #   config.view_component.show_previews = true

  #   # Allow runtime parsing, otherwise in prod mode previews are not found.
  #   config.lookbook.runtime_parsing = true

  #   config.lookbook.preview_display_options = {
  #     locale: Rails.application.config.advertised_locales
  #   }
  # end
end
