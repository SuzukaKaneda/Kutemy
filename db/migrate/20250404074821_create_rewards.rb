class CreateRewards < ActiveRecord::Migration[7.2]
  def change
    create_table :rewards do |t|
      t.integer :required_points
      t.text :content
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
