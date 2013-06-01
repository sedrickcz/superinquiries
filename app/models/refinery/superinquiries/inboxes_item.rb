module Refinery
  module Superinquiries
    class InboxesItem < Refinery::Core::BaseModel
      self.table_name = 'refinery_superinquiries_inboxes_items'

      attr_accessible :inbox_id, :input_name, :value

      belongs_to :inbox

      def is_valid?
        if required? and value.blank?
          errors.add(::I18n.t("#{input_name}"), ::I18n.t('superinquiry.cannot_be_blank'))
          
          return false
        else
          return true
        end
      end

      def required?
        inbox.superinquiry.inquiry_inputs.where(superform_id: input_name).first.try(:required)
      end
    end
  end
end
