class CreateStatsupdaters < ActiveRecord::Migration
  def change
    create_table :statsupdaters do |t|
      t.text :name
      t.datetime :interval

      t.timestamps null: false
    end
  end
end
