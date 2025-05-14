class RewardsController < ApplicationController
  def index
    @rewards = Reward.where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @user = User.find(current_user.id)
    @point = @user.point
    @reward = Reward.new
  end

  def create
    @reward = current_user.rewards.build(reward_params)
    respond_to do |format|
        if @reward.save
          format.html { redirect_to user_point_path, notice: "目標を作成しました。" }
          format.json { render :user_point_path, status: :created, location: @reward }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @reward.errors, status: :unprocessable_entity }
        end
    end
  end

  def update_completed
    @reward = Reward.find(params[:reward_id])
    @reward.update(completed: true)
    head :ok
  end

  private

  def reward_params
    params.require(:reward).permit(:required_points, :content)
  end
end
