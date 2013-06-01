module Refinery
  module Superinquiries
    module SuperinquiriesHelper
      def superinquiry_form name, options = {}
        @superinquiry = Refinery::Superinquiries::Superinquiry.where(title: name).first
        form_tag([refinery,:superinquiries, @inbox = Refinery::Superinquiries::Inbox.new]) do
          raw get_inputs(@superinquiry, options) +
          hidden_field_tag(:superinquiry_id, @superinquiry.id) +
          "<div class='field validity hidden'>"+
          hidden_field_tag("items[validity]")+
          "</div>"+
          submit_tag(:submit)
        end
      end

      def get_inputs superinquiry, options = {}
        inputs = []
        superinquiry.inquiry_inputs.each do |input|
          inputs << generate_input(input.superform_id, options)
        end
        inputs.join("<br />")
      end

      def generate_input name, options = {}
        input = Refinery::Superinquiries::SuperForm::SUPERFORMS[name.to_sym]
        case input.form_type
        when "text_field"
          label_tag(input.name) +
          text_field_tag("items[#{input.name}]")
        when "text_area"
          label_tag(input.name) +
          text_area_tag("items[#{input.name}]")
        when "select"
          label_tag(input.name) +
          select_tag("items[#{input.name}]", options_for_select(options[input.name.to_sym].collect{|a| [a[0],a[1]]})) if options[input.name.to_sym]
      end
    end
  end
end
end