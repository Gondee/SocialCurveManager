class AddClicksToGeneratedlinks < ActiveRecord::Migration
  def change
    add_column :generatedlinks, :clicks, :integer
  end
end
