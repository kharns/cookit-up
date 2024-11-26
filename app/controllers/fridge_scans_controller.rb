class FridgeScansController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new]

  def new
    @fridge_scan = FridgeScan.new
  end
end
