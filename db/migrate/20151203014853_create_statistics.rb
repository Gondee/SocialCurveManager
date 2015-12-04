class CreateStatistics < ActiveRecord::Migration
  def change
    create_table :statistics do |t|
      t.integer :generatedlink_id
      t.integer :clicks

      t.timestamps null: false
    end
  end
end
