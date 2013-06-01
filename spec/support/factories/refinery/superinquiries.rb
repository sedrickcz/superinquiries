
FactoryGirl.define do
  factory :superinquiry, :class => Refinery::Superinquiries::Superinquiry do
    sequence(:title) { |n| "refinery#{n}" }
  end
end

