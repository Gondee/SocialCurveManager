class CreateClearingHouses < ActiveRecord::Migration
  def change
    create_table :clearing_houses do |t|
      t.integer :publisher_id
      t.integer :user_id
      t.text :note

      t.timestamps null: false
    end
  end
end
