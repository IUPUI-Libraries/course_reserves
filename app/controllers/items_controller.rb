class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  include Pagy::Backend

  # GET /items
  # GET /items.json
  def index
    @q = Item.ransack(params[:q])
    @pagy, @items = pagy(policy_scope(@q.result))
  end

  # GET /items/1
  # GET /items/1.json
  def show
    authorize @item
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ItemPdf.new(@item)
        pdf.create_tag
        send_data pdf.render,
                  filename: "item_#{@item.id}",
                  type: 'application/pdf',
                  disposition: 'inline'
      end
    end
  end

  # GET /items/new
  def new
    pending = ItemStatus.find_by(status: 'Pending')
    @item = Item.new(item_status_id: pending.id)
  end

  # GET /items/1/edit
  def edit
    authorize @item
  end

  # GET /items/1/expire
  def expire
    @item = Item.find(params[:id])
    @course = Course.find(@item.course_id)
    authorize @item
    @item.item_status_id = ItemStatus.find_by(status: 'Expired').id
    respond_to do |format|
      if @item.save
        format.html { redirect_to course_url(@course), notice: 'Item expired.' }
      else
        format.html { redirect_to course_url(@course), notice: 'Item could not be expired.' }
      end
    end
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)
    authorize @item
    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    authorize @item
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy
    authorize @item
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:item).permit(policy(@item).permitted_attributes)
    end
end
