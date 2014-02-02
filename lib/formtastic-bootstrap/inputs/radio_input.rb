module FormtasticBootstrap
  module Inputs
    class RadioInput < Formtastic::Inputs::RadioInput
      include Base
      include Base::Choices

      # TODO Make sure help blocks work correctly.
      # TODO Support .inline

      def to_html
        bootstrap_wrapping do
          collection.map { |choice|
            choice_html(choice)
          }.join("\n").html_safe
        end
      end

      def wrapper_html_options
        # Formtastic marks these as 'radio' but Bootstrap does something
        # with that, so change it to 'radio_buttons'.
        super.tap do |options|
          options[:class] = options[:class].gsub("radio", "radio_buttons")
        end
      end

      def choice_html(choice)
        radio_wrapping do
          template.content_tag(:label,
            builder.radio_button(input_name, choice_value(choice), input_html_options.merge(choice_html_options(choice)).merge(:required => false)) <<
            choice_label(choice),
            label_html_options.merge(choice_label_html_options(choice))
          )
        end
      end

      def radio_wrapping(&block)
        template.content_tag(:div,
          template.capture(&block).html_safe,
          :class => "radio"
        )
      end

    end
  end
end

