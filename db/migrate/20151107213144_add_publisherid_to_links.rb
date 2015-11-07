class AddPublisheridToLinks < ActiveRecord::Migration
  def change
    add_column :links, :publisher_id, :integer
  end
end
