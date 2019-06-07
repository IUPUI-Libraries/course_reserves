class DailyMailer < ApplicationMailer
  default from: CourseReserves.config[:email][:default_from]

  def summary_email
    mail(to: CourseReserves.config[:email][:daily_to], subject: 'Course Reserves Daily Summary')
  end
end
