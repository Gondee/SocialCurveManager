class AddLinksidToGeneratedlinks < ActiveRecord::Migration
  def change
    add_column :generatedlinks, :link_id, :integer
  end
end
