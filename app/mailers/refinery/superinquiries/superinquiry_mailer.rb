module Refinery
  module Superinquiries
    class SuperinquiryMailer < ActionMailer::Base

      def confirmation(inbox, request)
        @inbox = inbox
        email = @inbox.get_email
        if email.present?
          mail :subject => ::Refinery::Setting.find_or_set(:superinquiry_confirmation_subject, t('superinquiry.confirmation_subject')),
          :to => email,
          :from => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
          :reply_to => ::Refinery::Setting.find_or_set(:superinquiry_recipients, "").split(',').first
        end
      end

      def notification(inbox, request)
        @inbox = inbox
        email = @inbox.get_email || ""
        mail :subject => ::Refinery::Setting.find_or_set(:superinquiry_notification_subject, t('superinquiry.notification_subject')),
        :to => ::Refinery::Setting.find_or_set(:superinquiry_notifications_recipients, ""),
        :from => "\"#{Refinery::Core.site_name}\" <no-reply@#{request.domain}>",
        :reply_to => email
      end
    end
  end
end
