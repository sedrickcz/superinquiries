module Refinery
  module Superinquiries
    module Admin
      class SuperinquiriesController < ::Refinery::AdminController

        after_filter :build_inquiry_inputs, only: :new

        crudify :'refinery/superinquiries/superinquiry', :xhr_paging => true

        def index
          @superinquiries = Refinery::Superinquiries::Superinquiry.all
          if params[:superinquiry].present?
            @inboxes = Refinery::Superinquiries::Inbox.where(superinquiry_id: params[:superinquiry], spam: false)
          else
            if params[:spam].to_i == 1
              @inboxes = Refinery::Superinquiries::Inbox.where(spam: true)
            else
              @inboxes = Refinery::Superinquiries::Inbox.where(spam: false)
            end
          end
          @inboxes = @inboxes.paginate(:page => params[:page])
          @spam = Refinery::Superinquiries::Inbox.where(spam: true).size
        end

        def show_inbox
          @inbox = Refinery::Superinquiries::Inbox.find(params[:id])
        end

        def delete_inbox
          @inbox = Refinery::Superinquiries::Inbox.find(params[:id])
          @inbox.destroy

          respond_to do |format|
            format.html { redirect_to :back}
          end
        end

        def change_state
          @inbox = Refinery::Superinquiries::Inbox.find(params[:id])
          @inbox.check_or_uncheck_inquiry
          redirect_to :back
        end

        def change_spam
          @inbox = Refinery::Superinquiries::Inbox.find(params[:id])
          if @inbox.spam
            @inbox.ham!
          else
            @inbox.spam!
          end
          redirect_to :back
        end
        private

        def build_inquiry_inputs
          @superinquiry.inquiry_inputs.build
        end
      end
    end
  end
end
