class AddAccountTypeToUsers < ActiveRecord::Migration
  def change
    add_column :users, :publisher, :boolean
  end
end
