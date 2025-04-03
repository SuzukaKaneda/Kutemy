class PointsController < ApplicationController

  def index
    @user = User.find(current_user.id)
  end

  def create
    @user = User.find(current_user.id)
    @point = @user.points.build(add: params[:add])
  
    if @point.save
      redirect_to user_points_path(@user), notice: 'ポイントが加算されました。'
    else
      render :new
    end
  end

end