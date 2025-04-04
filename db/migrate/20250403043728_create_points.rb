class CreatePoints < ActiveRecord::Migration[7.2]
  def change
    create_table :points do |t|
      t.references :user, foreign_key: true
      t.integer :add

      t.timestamps
    end
  end
end
