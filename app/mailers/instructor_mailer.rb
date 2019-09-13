class InstructorMailer < ApplicationMailer
  default from: CourseReserves.config[:email][:default_from]

  def new_course_email(course)
    @course = course
    mail(to: course.instructor_email, subject: 'New Course Reserves added')
  end
end
