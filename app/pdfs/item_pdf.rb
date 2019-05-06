class ItemPdf
  include Prawn::View

  require 'prawn/measurement_extensions'

  def initialize(item)
    @item = item
    @course = Course.find(@item.course_id)
    @document = Prawn::Document.new(page_size: [11.in, 17.in], page_layout: :portrait)
  end

  def create_tag
    font 'Helvetica'
    font_size 14
    add_left_column
    add_page_split
    add_right_column
  end

  def add_left_column
    bounding_box([0.75.in, 15.5.in], width: 4.in) do
      font('Helvetica-Bold') do
        text "Title: #{Prawn::Text::NBSP * 14} #{@item.title}"
        text "Author: #{Prawn::Text::NBSP * 10} #{@item.author}"
        move_down 0.75.in
        text Department.find(@course.department_id).name.to_s
        text @course.course_number.to_s
        text @course.name.to_s
        text Semester.find(@course.semester_id).semester.to_s
        text @course.instructor.to_s
      end
      move_down 0.75.in
      text "Course ID: #{@course.id}"
      text "Item ID: #{@item.id}"
    end
  end

  def add_page_split
    stroke_line [5.in, 16.in], [5.in, 5.in]
  end

  def add_right_column
    bounding_box([6.in, 14.in], width: 4.in) do
      period = LoanPeriod.find(@item.loan_period_id).length.to_s
      font('Helvetica-Bold') do
        text "#{period} (library use only)",
             align: :center,
             color: '990000',
             size: 18
        move_down 0.25.in
        text "Reserve Item",
             align: :center,
             color: '990000',
             size: 18
      end
      move_down 0.25.in
      text 'Burrower is responsible for returning this item to the Circulation Desk.',
           align: :center
      move_down 0.25.in
      font('Helvetica-Bold') do
        text Department.find(@course.department_id).name.to_s,
             align: :center,
             size: 18
       text @course.course_number.to_s,
            align: :center,
            size: 18
      end
      text @course.name, align: :center
      move_down 0.25.in
      font('Helvetica-Bold') do
        text @item.title.to_s, align: :center
        text @item.author.to_s, align: :center
      end
      text "Course ID: #{@course.id}", align: :center
      text "Item ID: #{@item.id}", align: :center
      move_down 0.25.in
      text 'This item is renewable if not requested by another patron.',
           align: :center,
           size: 11
      text 'Renewals must be made in person.',
           align: :center,
           size: 11
      move_down 0.25.in
      text 'Any of these materials deposited in a drop box
           will be subject to all relevant fines.',
           align: :center
      move_down 0.25.in
      text 'Minimum Fine Schedule for Late Returns', align: :center
      text '$5 PER HOUR per ITEM', align: :center
    end
  end

end
