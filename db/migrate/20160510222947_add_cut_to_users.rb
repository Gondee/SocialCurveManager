class AddCutToUsers < ActiveRecord::Migration
  def change
    add_column :users, :cut, :decimal, default: 20
  end
end
