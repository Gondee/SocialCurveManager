class AddExpireToGeneratedlinks < ActiveRecord::Migration
  def change
    add_column :generatedlinks, :expire, :integer, :default => 10
  end
end
