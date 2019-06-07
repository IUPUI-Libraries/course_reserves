class LetterMailer < ApplicationMailer
  default from: CourseReserves.config[:email][:default_from]

  def letter_email
    @letter = params[:letter]
    @letter.from ||= CourseReserves.config[:email][:default_from]
    mail(to: @letter.recipient, from: @letter.from, subject: @letter.subject)
  end
end
