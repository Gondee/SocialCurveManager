class ChangeDataTypeForCreatedAt < ActiveRecord::Migration
  def change
    change_column(:links,:date,:datetime)
    change_column(:generatedlinks,:date,:datetime)
  end
end
