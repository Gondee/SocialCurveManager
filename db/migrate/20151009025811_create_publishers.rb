class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :first
      t.string :last
      t.string :address
      t.string :phone
      t.string :company
      t.string :position
      t.text :note

      t.timestamps null: false
    end
  end
end
