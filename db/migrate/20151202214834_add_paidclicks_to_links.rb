class AddPaidclicksToLinks < ActiveRecord::Migration
  def change
    add_column :links, :paidclicks, :integer
  end
end
