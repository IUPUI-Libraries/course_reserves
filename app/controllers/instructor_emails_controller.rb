class InstructorEmailsController < ApplicationController
  before_action :set_instructor_email, only: [:show, :edit, :update, :destroy]

  # GET /instructor_emails
  # GET /instructor_emails.json
  def index
    @instructor_emails = InstructorEmail.all
  end

  # GET /instructor_emails/1
  # GET /instructor_emails/1.json
  def show
  end

  # GET /instructor_emails/new
  def new
    @instructor_email = InstructorEmail.new
  end

  # GET /instructor_emails/1/edit
  def edit
  end

  # POST /instructor_emails
  # POST /instructor_emails.json
  def create
    @instructor_email = InstructorEmail.new(instructor_email_params)

    respond_to do |format|
      if @instructor_email.save
        format.html { redirect_to @instructor_email, notice: 'Instructor email was successfully created.' }
        format.json { render :show, status: :created, location: @instructor_email }
      else
        format.html { render :new }
        format.json { render json: @instructor_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /instructor_emails/1
  # PATCH/PUT /instructor_emails/1.json
  def update
    respond_to do |format|
      if @instructor_email.update(instructor_email_params)
        format.html { redirect_to @instructor_email, notice: 'Instructor email was successfully updated.' }
        format.json { render :show, status: :ok, location: @instructor_email }
      else
        format.html { render :edit }
        format.json { render json: @instructor_email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /instructor_emails/1
  # DELETE /instructor_emails/1.json
  def destroy
    @instructor_email.destroy
    respond_to do |format|
      format.html { redirect_to instructor_emails_url, notice: 'Instructor email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_instructor_email
    @instructor_email = InstructorEmail.find(params[:id])
  end

  # Never trust parameters from the scary internet,
  # only allow the white list through.
  def instructor_email_params
    params.require(:instructor_email).permit(
      :send_option, :semester, :instuctors,
      :library, :message, :sent_date,
      :library_id, semester_id: []
    )
  end
end
