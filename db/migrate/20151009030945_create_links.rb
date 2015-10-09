class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :url
      t.date :date
      t.boolean :used

      t.timestamps null: false
    end
  end
end
