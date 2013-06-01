module Refinery
  module Superinquiries
    class Superinquiry < Refinery::Core::BaseModel
      self.table_name = 'refinery_superinquiries'

      attr_accessible :title, :position, :inquiry_inputs_attributes

      acts_as_indexed :fields => [:title]

      validates :title, :presence => true, :uniqueness => true

      has_many :inquiry_inputs, dependent: :destroy
      accepts_nested_attributes_for :inquiry_inputs, reject_if: lambda {|t| t[:superform_id].blank? }, :allow_destroy => true

    
    end
  end
end
