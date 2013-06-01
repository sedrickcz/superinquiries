module Refinery
  module Superinquiries
    class SuperinquiriesController < ::ApplicationController

      before_filter :find_all_superinquiries
      before_filter :find_page

      def index
        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @superinquiry in the line below:
        present(@page)
      end

      def show
        @superinquiry = Superinquiry.find(params[:id])

        # you can use meta fields from your model instead (e.g. browser_title)
        # by swapping @page for @superinquiry in the line below:
        present(@page)
      end

    protected

      def find_all_superinquiries
        @superinquiries = Superinquiry.order('position ASC')
      end

      def find_page
        @page = ::Refinery::Page.where(:link_url => "/superinquiries").first
      end

    end
  end
end
