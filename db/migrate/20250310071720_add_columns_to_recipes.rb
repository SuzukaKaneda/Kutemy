class AddColumnsToRecipes < ActiveRecord::Migration[7.2]
  def change
    add_column :recipes, :trick, :text
    add_column :recipes, :get_point, :integer, null: false
  end
end
