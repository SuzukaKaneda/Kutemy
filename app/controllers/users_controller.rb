class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: "情報の更新に成功しました。" }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def total_point
    @user = User.find(current_user.id)
    @point = @user.point
    @reward = Reward.where(user_id: current_user.id).order(created_at: :desc).limit(1).first
  end

  def add_point
    @user = User.find(current_user.id)
    @user.point += params[:add].to_i
    @point = @user.point
    @reward = Reward.where(user_id: current_user.id).order(created_at: :desc).limit(1).first
    if @user.save
      redirect_to user_point_path(@user), notice: 'ポイントが加算されました。' 
    else
      render :new
    end
  end

  def subtract_point
    @user = User.find(current_user.id)
    @user.point -= params[:subtract].to_i
  
    if @user.save
      redirect_to user_point_path(@user), notice: 'ポイントが減算されました。'
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name)
  end
end
