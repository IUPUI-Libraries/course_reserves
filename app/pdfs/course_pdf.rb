class CoursePdf
  include Prawn::View

  require 'prawn/measurement_extensions'

  def initialize(course)
    @course = course
    @items = @course.items
    @department = Department.find(@course.department_id).name.to_s
    @semester = Semester.find(@course.semester_id).semester.to_s
    @document = Prawn::Document.new(page_size: [11.in, 17.in], page_layout: :portrait)
  end

  def create_tags
    font 'Helvetica'
    font_size 14
    @items.each_with_index do |item, index|
      if index.even?
        add_left_column(item)
        add_page_split
      else
        add_right_column(item)
        add_page_break if index < @items.count - 1
      end
    end
  end

  def add_left_column(item)
    bounding_box([0.5.in, 14.in], width: 4.in) do
      add_item_content(item)
    end
  end

  def add_right_column(item)
    bounding_box([6.in, 14.in], width: 4.in) do
      add_item_content(item)
    end
  end

  def add_page_split
    stroke_line [5.in, 16.in], [5.in, 5.in]
  end

  def add_page_break
    start_new_page
  end

  def add_item_content(item)
    period = LoanPeriod.find(item.loan_period_id).length.to_s
    use = LoanPeriod.find(item.loan_period_id).use.to_s
    period_use = use.empty? ? period : "#{period} (#{use})"
    font('Helvetica-Bold') do
      text period_use,
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
      text @department,
           align: :center,
           size: 18
      text @course.course_number.to_s,
           align: :center,
           size: 18
    end
    text @course.name, align: :center
    move_down 0.25.in
    font('Helvetica-Bold') do
      text item.title.to_s, align: :center
      text item.author.to_s, align: :center
    end
    text "Course ID: #{@course.id}", align: :center
    text "Item ID: #{item.id}", align: :center
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
