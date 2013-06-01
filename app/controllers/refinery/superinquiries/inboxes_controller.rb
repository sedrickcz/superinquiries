module Refinery
  module Superinquiries
    class InboxesController < ::ApplicationController

      def create
        @error = false
        @errors = []
        ActiveRecord::Base.transaction do
          @inbox = Refinery::Superinquiries::Inbox.new(superinquiry_id: params[:superinquiry_id], validity: params[:items][:validity])
          if @inbox.save
            @inbox.spam! if @inbox.spam?
            @items = params[:items]
            @saved_items = []
            @items.each do |key, value|
              @item = @inbox.inboxes_items.new(input_name: key, value: value)
              if @item.is_valid?
                @saved_items << @item
              else
                @error = true
                @errors << @item.errors.full_messages
              end
            end
            if !@error and @saved_items.any?
              @saved_items.each{|item| item.save}
              flash[:notice] = "All ok"
            else
              raise ActiveRecord::Rollback
              flash[:notice] = @errors
            end


            begin
              ::Refinery::Superinquiries::SuperinquiryMailer.notification(@inbox, request).deliver
            rescue
              logger.warn "There was an error delivering an inquiry notification.\n#{$!}\n"
            end

            begin
              ::Refinery::Superinquiries::SuperinquiryMailer.confirmation(@inbox, request).deliver
            rescue
              logger.warn "There was an error delivering an inquiry confirmation:\n#{$!}\n"
            end if ::Refinery::Setting.find_or_set(:superinquiries_send_confirmation, true)
          else
            flash[:notice] = "Fail"
          end
        end
        flash[:notice] = @errors.join("<br/>")
        redirect_to :back
      end

      def thank_you
        @page = ::Refinery::Page.find_by_link_url("/kontakt/dekujeme")
      end


    end
  end
end
