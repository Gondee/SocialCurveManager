class RemoveFieldNameFromPublishers < ActiveRecord::Migration
  def change
    remove_column :publishers, :first, :string
    remove_column :publishers, :last, :string
    remove_column :publishers, :address, :string
    remove_column :publishers, :phone, :string
    remove_column :publishers, :note, :string
  end
end
