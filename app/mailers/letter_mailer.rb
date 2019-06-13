class LetterMailer < ApplicationMailer
  default from: CourseReserves.config[:email][:default_from]

  def letter_email
    @letter = params[:letter]
    @letter.from ||= CourseReserves.config[:email][:default_from]
    mail(to: @letter.from, from: @letter.from, bcc: @letter.recipient, subject: @letter.subject)
  end
end
