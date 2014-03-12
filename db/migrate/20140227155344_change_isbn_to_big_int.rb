class ChangeIsbnToBigInt < ActiveRecord::Migration
  def change
    change_column :books, :isbn, :integer, limit: 8
  end
end
