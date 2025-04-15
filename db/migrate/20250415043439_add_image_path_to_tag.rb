class AddImagePathToTag < ActiveRecord::Migration[7.2]
  def change
    add_column :tags, :image_path, :string
  end
end
