class CreatePaymentgroups < ActiveRecord::Migration
  def change
    create_table :paymentgroups do |t|
      t.integer :transaction_id
      t.integer :generatedlink_id
      t.text :note

      t.timestamps null: false
    end
  end
end
