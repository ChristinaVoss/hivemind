# frozen_string_literal: true

require 'axe-rspec'
require 'axe-capybara'

AxeCapybara.configure(:firefox) do |c|
  # Location of axe/core.rb, found by looking up where Axe::Core is defined.
  # e.g. /usr/local/bundle/gems/axe-core-api-4.4.0/lib/axe/core.rb
  axe_core_rb_path = Axe.const_source_location(:Core).first

  # **Assumed** location of the axe.js file within the axe-core-api gem
  axe_js_path = 'node_modules/axe-core/axe.min.js'

  # **Assume** that the core.rb file found above is `lib/axe/core.rb` within the gem
  axe_core_gem_root = File.expand_path("#{File.dirname(axe_core_rb_path)}/../../")

  # Glue these two assumptions together.  This avoids having to check-in axe.js.
  c.jslib_path = File.join(axe_core_gem_root, axe_js_path)
end

# Available standards are:
#
#   wcag2a        WCAG 2.0 Level A
#   wcag2aa       WCAG 2.0 Level AA
#   wcag2aaa      WCAG 2.0 Level AAA
#   wcag21a       WCAG 2.1 Level A
#   wcag21aa      WCAG 2.1 Level AA
#   wcag21aaa     WCAG 2.1 Level AAA
#   best-practice Common accessibility best practices
#   ACT           W3C approved Accessibility Conformance Testing rules
#
# See https://github.com/dequelabs/axe-core/blob/master/doc/API.md#axe-core-tags
#
# Currently testing up to AAA standards:
AXE_STANDARDS = %i[wcag2a wcag2aa wcag2aaa wcag21a wcag21aa wcag21aaa best-practice ACT].freeze

RSpec.shared_examples 'an accessible component' do |args|
  it 'is axe clean', js: true do
    expect(page).to be_axe_clean.within(args[:within])
                                .according_to(*AXE_STANDARDS)
                                .skipping(*Array(args[:skipping]))
  end
end
