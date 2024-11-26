class FridgeScansController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[new create]

  def new
    @fridge_scan = FridgeScan.new
  end

  def create
    @fridge_scan = FridgeScan.new(scan_params)
    # User_id => optional
    @fridge_scan.user = current_user unless current_user.nil?
    @fridge_scan.save
    raise
    # Ingredient_list => OpenAI
    #  CHATGPT PROMPT TEMPLATE FOR IMAGE (VISION)


  end

  private

  def scan_params
    params.require(:fridge_scan).permit(:photo)
  end
end
