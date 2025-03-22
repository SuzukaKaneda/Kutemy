class CreateInstructions < ActiveRecord::Migration[7.2]
  def change
    create_table :instructions do |t|
      t.integer :step
      t.text :content
      t.references :recipe, null: false, foreign_key: true

      t.timestamps
    end
  end
end
