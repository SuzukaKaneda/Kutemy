class AddPointToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :point, :integer
  end
end
