namespace :email do
  desc 'Send email to system admins about new courses and items.'
  task daily_summary: :environment do
    DailyMailer.summary_email.deliver
  end
end
