class ChangePointDefaultToZeroInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :point, 0
  end
end