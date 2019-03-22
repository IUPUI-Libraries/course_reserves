class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  include Pagy::Backend

  # GET /items
  # GET /items.json
  def index
    if params[:status]
      stat_id = ItemStatus.find_by(status: params[:status])
      @pagy, @items = pagy(policy_scope(Item.where(item_status_id: stat_id)))
    else
      @pagy, @items = pagy(policy_scope(Item))
    end
  end

  # GET /items/1
  # GET /items/1.json
  def show
    authorize @item
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
