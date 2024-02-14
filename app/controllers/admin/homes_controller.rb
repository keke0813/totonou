class Admin::HomesController < ApplicationController
  
  #権限設定
  before_action :authenticate_admin!
  
  def top
  end
end
