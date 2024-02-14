class Admin::PostSaunasController < ApplicationController
  
  #権限設定
  before_action :authenticate_admin!
  
  def index
  end

  def show
  end

  def edit
  end
end
