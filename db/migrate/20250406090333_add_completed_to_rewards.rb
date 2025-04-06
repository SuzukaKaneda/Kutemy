class AddCompletedToRewards < ActiveRecord::Migration[7.2]
  def change
    add_column :rewards, :completed, :boolean, default: false
  end
end
