# frozen_string_literal: true

module PreviewPathHelper
  def preview_path(component: described_class, variant: :default, params: {})
    component = component.to_s.sub(/Component(Preview)?$/, '')

    path = [component.underscore, variant].join('/')

    lookbook.lookbook_preview_path(path:, params:)
  end
end
