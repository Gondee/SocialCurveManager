class AddPaidoutamountToGeneratedlinks < ActiveRecord::Migration
  def change
    add_column :generatedlinks, :paidclicks, :integer, :default => 0
  end
end
