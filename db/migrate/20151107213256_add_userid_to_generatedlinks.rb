class AddUseridToGeneratedlinks < ActiveRecord::Migration
  def change
    add_column :generatedlinks, :user_id, :integer
  end
end
