class AddDeadToGeneratedlinks < ActiveRecord::Migration
  def change
    add_column :generatedlinks, :dead, :boolean, :default => false
  end
end
