class CreateGeneratedlinks < ActiveRecord::Migration
  def change
    create_table :generatedlinks do |t|
      t.string :url
      t.boolean :paidout
      t.date :date

      t.timestamps null: false
    end
  end
end
