module Refinery
  module Superinquiries
    class InquiryInput < Refinery::Core::BaseModel
      self.table_name = 'refinery_superinquiries_inquiry_inputs'

      attr_accessible :superinquiry_id, :superform_id, :required


    end
  end
end
