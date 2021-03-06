class LettersController < ApplicationController
  before_action :set_letter, only: [:show, :edit, :update, :destroy]

  include Pagy::Backend

  # GET /letters
  # GET /letters.json
  def index
    @q = Letter.ransack(params[:q])
    @pagy, @letters = pagy(policy_scope(@q.result))
  end

  # GET /letters/1
  # GET /letters/1.json
  def show
    authorize @letter
  end

  # GET /letters/new
  def new
    @letter = Letter.new
  end

  # GET /letters/1/edit
  def edit
    authorize @letter
  end

  # GET /letters/1/duplicate
  def duplicate
    @letter = Letter.find(params[:id]).duplicate
    render action: 'new'
  end

  # GET /letters/1/mail
  def mail
    @letter = Letter.find(params[:id])
    @letter.sent_date = Time.now
    respond_to do |format|
      if @letter.save
        LetterMailer.with(letter: @letter).letter_email.deliver_later
        format.html { redirect_to @letter, notice: 'Letter was successfully sent.' }
      end
    end
  end

  # POST /letters
  # POST /letters.json
  def create
    @letter = Letter.new(letter_params)
    @letter.recipient = helpers.recipient_list
    @letter.from = helpers.from_address
    authorize @letter
    respond_to do |format|
      if @letter.save
        format.html { redirect_to @letter, notice: 'Letter was successfully created.' }
        format.json { render :show, status: :created, location: @letter }
      else
        format.html { render :new }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /letters/1
  # PATCH/PUT /letters/1.json
  def update
    authorize @letter
    respond_to do |format|
      if @letter.update(letter_params)
        format.html { redirect_to @letter, notice: 'Letter was successfully updated.' }
        format.json { render :show, status: :ok, location: @letter }
      else
        format.html { render :edit }
        format.json { render json: @letter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /letters/1
  # DELETE /letters/1.json
  def destroy
    authorize @letter
    @letter.destroy
    respond_to do |format|
      format.html { redirect_to letters_url, notice: 'Letter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_letter
      @letter = Letter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def letter_params
      params.require(:letter).permit(:send_option, :recipient, :subject,
        :library_id, :message, :sent_date, :from, semester_ids: [])
    end
end
