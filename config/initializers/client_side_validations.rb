# frozen_string_literal: true

# rubocop:disable Rails/OutputSafety
# rubocop:disable Layout/LineLength
ClientSideValidations::Config.number_format_with_locale = true

ActionView::Base.field_error_proc = proc do |html_tag, instance|
  if /^<label/.match?(html_tag)
    %(<div class="field_with_errors">#{html_tag}</div>).html_safe
  else
    %(<div class="field_with_errors">#{html_tag}<label for="#{instance.send(:tag_id)}" class="message">#{instance.error_message.first}</label></div>).html_safe
  end
end
# rubocop:enable Layout/LineLength
# rubocop:enable Rails/OutputSafety
