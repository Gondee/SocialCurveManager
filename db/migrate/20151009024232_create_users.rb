class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first
      t.string :last
      t.string :address
      t.string :phone
      t.string :url
      t.text :note

      t.timestamps null: false
    end
  end
end
