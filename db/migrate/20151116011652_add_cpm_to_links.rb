class AddCpmToLinks < ActiveRecord::Migration
  def change
    add_column :links, :cpm, :double
  end
end
