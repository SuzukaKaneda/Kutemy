class ChangeNullConstraintInReward < ActiveRecord::Migration[7.2]
  def change
    change_column_null :rewards, :required_points, false
    change_column_null :rewards, :content, false
  end
end
