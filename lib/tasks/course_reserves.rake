namespace :course_reserves do
  desc 'Send summary email'
  # sends email with new courses, pending items, etc.
  task email_summary: :environment do
    DailyMailer.summary_email.deliver
  end
end
