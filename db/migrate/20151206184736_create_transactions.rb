class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.boolean :expense
      t.integer :user_id
      t.float :amount
      t.text :note

      t.timestamps null: false
    end
  end
end
