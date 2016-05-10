class AddPayPalToUsers < ActiveRecord::Migration
  def change
    add_column :users, :paypal, :string
  end
end
