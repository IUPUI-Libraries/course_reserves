class LetterMailer < ApplicationMailer
  default from: CourseReserves.config[:email][:default_from]

  def letter_email
    @letter = params[:letter]
    mail(to: @letter.recipient_list, subject: 'UL Course Reserves Letter')
  end
end
