# frozen_string_literal: true

module PreviewPathHelper
  include Lookbook::Utils

  def preview_path(preview_class: described_class, variant: :default, params: {})
    preview = Lookbook.previews.find_by_preview_class(preview_class) # rubocop:disable Rails/DynamicFindBy

    path = [preview.path, variant].join('/')

    lookbook.lookbook_preview_path(path:, params:)
  end
end
