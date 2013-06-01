module Refinery
  module Superinquiries
    class Inbox < Refinery::Core::BaseModel
      self.table_name = 'refinery_superinquiries_inboxes'

      attr_accessible :superinquiry_id, :checked, :spam, :validity
      attr_accessor :validity

      has_many :inboxes_items
      belongs_to :superinquiry

      default_scope :order => 'checked ASC,created_at DESC'

      #Spam methods
      def not_spam?
        return self.validity == "probably_valid"
      end

      def spam?
        self.validity != "probably_valid"
      end

      def ham
        self.validity == "probably_valid"
      end

      def ham!
        self.update_attribute(:spam, false)
      end

      def spam!
        self.update_attribute(:spam, true)
      end

      def check_or_uncheck_inquiry
        check = 0 if checked == 1
        check = 1 if checked == 0
        self.update_attribute(:checked, check)
      end

      def get_email
        inboxes_items.where(input_name: 'email').first.try(:value)
      end

      

    end
  end
end
