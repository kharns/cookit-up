class FridgeScansController < ApplicationController
  def show
    @fridge_scan = FridgeScan.find(params[:id])
  end
end
