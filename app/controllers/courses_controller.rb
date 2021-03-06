class CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  include Pagy::Backend

  # GET /courses
  # GET /courses.json
  def index
    @q = Course.ransack(params[:q])
    @pagy, @courses = pagy(policy_scope(@q.result))
  end

  # GET /courses/1
  # GET /courses/1.pdf
  def show
    authorize @course
    respond_to do |format|
      format.html
      format.pdf do
        pdf = CoursePdf.new(@course)
        pdf.create_tags
        send_data pdf.render,
                  filename: "course_#{@course.id}",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  # GET /courses/new
  def new
    @course = Course.new
    @course.items.build
    @course.instructor_username = current_user.uid
    @course.instructor_email = LdapService.fetch_info(current_user.uid)[:email]
  end

  # GET /courses/1/edit
  def edit
    @course.items.each do |item|
      item.user_id = @course.user_id
    end
    authorize @course
  end

  # GET /courses/1/duplicate
  def duplicate
    template = Course.find(params[:id])
    @course = template.duplicate # defined in Course.duplicate
    render action: 'new', notice: 'Review Course before Saving.'
  end

  # Get /course/1/available
  # Changes status to all items as available
  def available
    @course = Course.find(params[:id])
    authorize @course
    available_id = ItemStatus.find_by(status: 'Available').id
    @course.items.each do |item|
      item.item_status_id = available_id
      item.save
    end
    render :show
  end

  # Get /course/1/expired
  # Changes status of all course items to expired
  def expired
    @course = Course.find(params[:id])
    authorize @course
    expired_id = ItemStatus.find_by(status: 'Expired').id
    @course.items.each do |item|
      item.item_status_id = expired_id
      item.save
    end
    render :show
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)
    @course.user_id = current_user.id
    @course.items.each do |item|
      item.user_id = current_user.id
    end
    authorize @course
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    authorize @course
    respond_to do |format|
      if @course.update(course_params)
        # Make sure all items are owned by course_user after update
        @course.items.each do |item|
          item.user_id = @course.user_id
        end
        @course.save
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    authorize @course
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_course
    @course = Course.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def course_params
    params.require(:course).permit(
      :name, :course_number, :instructor, :instructor_username,
      :instructor_email, :library_id, :semester_id, :department_id,
      :department_name,
      items_attributes: policy(:item).permitted_attributes
    )
  end
end
