class IucatRecordsController < ApplicationController
  def show
    @record = IucatRecord.new(params[:id])
  end
end
